class AddClusterIdToTempCluster < ActiveRecord::Migration[5.2]
  def change
    add_column :temp_clusters, :cluster_id, :string
  end
end
