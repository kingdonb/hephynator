class AddKubeVersionToTempCluster < ActiveRecord::Migration[5.2]
  def change
    add_column :temp_clusters, :kube_version, :string
  end
end
