class TempClusterReaperJob
  include SuckerPunch::Job

  def perform(temp_cluster_id)
    ActiveRecord::Base.connection_pool.with_connection do
      tc = TempCluster.find(temp_cluster_id)
      if LocalTime.current_date >= tc.expiry_date
        # Rails.logger.info "(reaper doing nothing, this is only a test)"
        Rails.logger.info "Calling #tick to terminate #{tc.cluster_name}..."
        tc.tick
        if tc.terminated?
          Rails.logger.info "#{tc.cluster_name} was terminated."
        end
      else
        puts "TempClusterReaperJob for #{temp_cluster_id} was "\
          "called too early, try again later. Cluster may not "\
          "be terminated without another TempClusterReaperJob."
      end
    end
  end

  def self.perform_async_for(temp_cluster)
    s = seconds_until_termination_time_for(temp_cluster).to_i
    cn = temp_cluster.cluster_name
    id = temp_cluster.id
    if s > 0
      Rails.logger.info "Submitting TempClusterReaperJob for '#{cn}' with TempCluster#id:#{id}, termination is scheduled in #{s} seconds"
      perform_in(s, id)
    else
      Rails.logger.info "TempClusterReaperJob for '#{cn}' with TempCluster#id:#{id} is overdue, submitting reaper in async for immediate processing"
      perform_async(id)
    end
  end
  def self.seconds_until_termination_time_for(temp_cluster)
    termination_time(temp_cluster) - Time.now
  end
  def self.termination_time(temp_cluster)
    temp_cluster.expiry_date + 15.minutes
  end
end
