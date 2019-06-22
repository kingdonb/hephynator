class AddClusterNameToTempCluster < ActiveRecord::Migration[5.2]
  def change
    add_column :temp_clusters, :cluster_name, :string
  end
end
