class TempCluster < ApplicationRecord
  EXPIRY_DAYS = 4
  def expired?
    expiry_date <= LocalTime.current_date
  end
  def expiry_date
    created_date + EXPIRY_DAYS.days
  end
  def created_date
    created_at.to_date
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
    terminate!
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
