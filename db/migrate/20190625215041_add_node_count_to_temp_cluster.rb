class AddNodeCountToTempCluster < ActiveRecord::Migration[5.2]
  def change
    add_column :temp_clusters, :node_count, :int
  end
end
