# On application start, enqueue TempClusterReaperJob for any activated clusters
if defined?(::Rails::Server)
  TempCluster.enqueue_all_reaper_jobs
end
