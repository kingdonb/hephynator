class TempCluster < ApplicationRecord
  include StatusBadge

  scope :activated, ->{ where("cluster_name <> '' and terminated_at is NULL") }
  validates :node_count, numericality: {
    only_integer: true, allow_nil: true,
    greater_than: 0, less_than_or_equal_to: 3
  }

  before_destroy :expire_cluster
  before_update :cluster

  MAX_CLUSTERS = 1
  EXPIRY_DAYS = 4
  def activated?
    cluster_name.present?
  end
  def name
    if cluster_name.present?
      cluster_name
    else
      "(unnamed)"
    end
  end
  def expired?
    expiry_date <= LocalTime.current_date ||
      terminated_at.present?
  end
  def long_expiry_date
    "#{expiry_date.strftime("%A")}, #{expiry_date.strftime("%F")}"
  end
  def expiry_date
    created_date + EXPIRY_DAYS.days
  end
  def created_date
    LocalTime.d(created_at)
  end
  def cluster
    @cluster ||=
      if cluster_id.blank?
        create_cluster
      else
        get_cluster
      end
  end

  def kubeconfig
    credentials
  end

  def expire_cluster
    terminate! if activated?
  end

  def terminated?
    terminated_at.present?
  end

  def tick
    unless terminated?
      expire_cluster if expired?
    end
  end

  private

  def cloud
    @cloud ||= Cloud::DigitalOcean.new
  end

  class ClusterCreationFailed < StandardError; end
  def create_cluster
    if any_leases_available?
      if valid?
        c = cloud.gimme_a_new_cluster(node_count: node_count)
        self.cluster_id = c.id
        self.cluster_name = c.name
        save!
        c
      else
        raise ClusterCreationFailed, "validation failure: #{errors.messages.to_s}"
      end
    else
      raise ClusterCreationFailed, "no leases available!"
    end
  end
  def terminate!
    self.terminated_at = Time.now
    save
    cloud.terminate_cluster(cluster_id)
  end
  def credentials
    self.last_credentials_at = Time.now
    save
    cloud.kubeconfig(cluster_id)
  end
  def get_cluster
    cloud.find_cluster(id: cluster_id)
  end
  def any_leases_available?
    TempCluster.activated.count < MAX_CLUSTERS
  end
end
