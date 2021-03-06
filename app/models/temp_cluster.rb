class TempCluster < ApplicationRecord
  include StatusBadge

  scope :activated, ->{ where("cluster_name <> '' and terminated_at is NULL") }
  validates :node_count, numericality: {
    only_integer: true, allow_nil: true,
    greater_than: 0, less_than_or_equal_to: 3
  }

  before_destroy :expire_cluster
  before_update :cluster

  def self.enqueue_all_reaper_jobs
    activated.each do |temp_cluster|
      TempClusterReaperJob.perform_async_for(temp_cluster)
    end

    return true
  end

  MAX_CLUSTERS = 3
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

    if @cluster.class.to_s == 'Cloud::DigitalOcean::NotCluster'
      e = @cluster
      @cluster = nil
      raise e
    end

    @cluster
  end

  def kubeconfig
    credentials
  end

  def available_kube_versions
    cloud.kube_versions
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
        c = cloud.gimme_a_new_cluster(node_count: node_count, kube_version: kube_version)
        self.cluster_id = c.id
        self.cluster_name = c.name
        save!
        TempClusterReaperJob.perform_async_for(self)
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
  rescue Cloud::DigitalOcean::NotCluster => e
    Rails.logger.info "#{e}, #{self.cluster_name}: '#{self.cluster_id}' appears to have been destroyed already."
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
