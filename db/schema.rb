# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_12_19_221624) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "vector"

# Could not dump table "documents" because of following StandardError
#   Unknown type 'vector' for column 'embedding'


  create_table "leave_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "employee_name"
    t.date "end_date"
    t.date "start_date"
    t.string "status", default: "Pending"
    t.datetime "updated_at", null: false
  end
end
