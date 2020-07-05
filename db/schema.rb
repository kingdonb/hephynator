# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_06_171130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "temp_clusters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cluster_id"
    t.datetime "terminated_at"
    t.string "cluster_name"
    t.datetime "last_credentials_at"
    t.integer "node_count"
    t.string "kube_version"
  end

end
