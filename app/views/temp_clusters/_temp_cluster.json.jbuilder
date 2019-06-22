json.extract! temp_cluster, :id, :created_at, :updated_at,
  :cluster_id, :cluster_name, :terminated_at, :last_credentials_at
json.url temp_cluster_url(temp_cluster, format: :json)
