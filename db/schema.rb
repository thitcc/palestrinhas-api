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

ActiveRecord::Schema[7.0].define(version: 2023_10_23_172035) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conferences", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "schedule"
  end

  create_table "lectures", force: :cascade do |t|
    t.string "title", null: false
    t.integer "duration", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "track_id", null: false
    t.string "session"
    t.integer "starting_time"
    t.index ["track_id"], name: "index_lectures_on_track_id"
    t.check_constraint "session::text = ANY (ARRAY['morning'::character varying, 'afternoon'::character varying]::text[])", name: "check_valid_session"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "identifier", null: false
    t.integer "morning_session_start"
    t.integer "morning_session_end"
    t.integer "afternoon_session_start"
    t.integer "afternoon_session_end"
    t.integer "networking_event_start"
    t.bigint "conference_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conference_id"], name: "index_tracks_on_conference_id"
  end

  add_foreign_key "lectures", "tracks"
  add_foreign_key "tracks", "conferences"
end
