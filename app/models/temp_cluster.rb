class TempCluster < ApplicationRecord
  include StatusBadge

  before_destroy :expire_cluster
  before_update :cluster

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

  private

  def cloud
    @cloud ||= Cloud::DigitalOcean.new
  end

  class NotImplementedYet < StandardError; end
  def create_cluster
    c = cloud.gimme_a_new_cluster
    self.cluster_id = c.id
    self.cluster_name = c.name
    save
    c
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
end
