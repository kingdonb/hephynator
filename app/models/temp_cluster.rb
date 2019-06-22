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

  private

  def cloud
    @cloud ||= Cloud::DigitalOcean.new
  end

  class NotImplementedYet < StandardError; end
  def create_cluster
    c = cloud.gimme_a_new_cluster
    self.cluster_id = c.id
    save
    c
  end
  def terminate!
    cloud.terminate_cluster(cluster_id)
  end
  def credentials
    cloud.kubeconfig(cluster_id)
  end
  def get_cluster
    cloud.find_cluster(id: cluster_id)
  end
end
