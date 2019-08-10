# On application start, enqueue TempClusterReaperJob for any activated clusters
Rails.application.config.after_initialize do
  if defined?(::Rails::Server)
    TempCluster.enqueue_all_reaper_jobs
  end
end
