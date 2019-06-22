class CreateTempClusters < ActiveRecord::Migration[5.2]
  def change
    create_table :temp_clusters do |t|

      t.timestamps
    end
  end
end
