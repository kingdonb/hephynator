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
    if cluster_id.blank?
      create_cluster
    else
      cloud.find_cluster(id: cluster_id)
    end
  end

  private

  def cloud
    @cloud ||= Cloud::DigitalOcean.new
  end

  class NotImplementedYet < StandardError; end
  def create_cluster
    binding.pry
    #
    raise NotImplementedYet
  end
end
