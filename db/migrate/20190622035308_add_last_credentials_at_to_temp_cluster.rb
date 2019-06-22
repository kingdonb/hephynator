class AddLastCredentialsAtToTempCluster < ActiveRecord::Migration[5.2]
  def change
    add_column :temp_clusters, :last_credentials_at, :timestamp
  end
end
