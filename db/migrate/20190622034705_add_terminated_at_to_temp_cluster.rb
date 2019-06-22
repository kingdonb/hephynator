class AddTerminatedAtToTempCluster < ActiveRecord::Migration[5.2]
  def change
    add_column :temp_clusters, :terminated_at, :timestamp
  end
end
