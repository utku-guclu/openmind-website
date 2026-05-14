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

ActiveRecord::Schema[8.1].define(version: 2026_05_14_113047) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "timescaledb"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.bigint "author_id"
    t.string "author_type"
    t.text "body"
    t.datetime "created_at", null: false
    t.string "namespace"
    t.bigint "resource_id"
    t.string "resource_type"
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "last_sign_in_at"
    t.string "last_sign_in_ip"
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role", default: "editor"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "analytics_events", id: false, force: :cascade do |t|
    t.string "country"
    t.string "device_type"
    t.string "event_type", null: false
    t.string "page_path"
    t.jsonb "properties", default: {}
    t.timestamptz "recorded_at", null: false
    t.string "referrer"
    t.string "session_id"
    t.index ["event_type", "recorded_at"], name: "idx_analytics_event_type", order: { recorded_at: :desc }
    t.index ["recorded_at"], name: "analytics_events_recorded_at_idx", order: :desc
    t.index ["session_id", "recorded_at"], name: "idx_analytics_session", order: { recorded_at: :desc }
  end

  create_table "contact_messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.text "message"
    t.string "name", null: false
    t.string "status", default: "unread"
    t.string "subject"
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_contact_messages_on_status"
  end

  create_table "destinations", force: :cascade do |t|
    t.string "country_code", limit: 2
    t.datetime "created_at", null: false
    t.text "description"
    t.decimal "latitude", precision: 10, scale: 7
    t.decimal "longitude", precision: 10, scale: 7
    t.jsonb "meta", default: {}
    t.string "name", null: false
    t.integer "position", default: 0
    t.string "slug", null: false
    t.string "status", default: "active"
    t.text "summary"
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_destinations_on_slug", unique: true
    t.index ["status"], name: "index_destinations_on_status"
  end

  create_table "impact_metrics", id: false, force: :cascade do |t|
    t.jsonb "meta", default: {}
    t.string "metric_name", null: false
    t.timestamptz "recorded_at", null: false
    t.string "source"
    t.string "unit"
    t.decimal "value", null: false
    t.index ["metric_name", "recorded_at"], name: "idx_impact_metric_name", order: { recorded_at: :desc }
    t.index ["recorded_at"], name: "impact_metrics_recorded_at_idx", order: :desc
  end

  create_table "partners", force: :cascade do |t|
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.integer "position", default: 0
    t.string "tier", default: "standard"
    t.datetime "updated_at", null: false
    t.string "url"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "author_id"
    t.text "body"
    t.string "category"
    t.datetime "created_at", null: false
    t.jsonb "meta", default: {}
    t.datetime "published_at"
    t.string "slug", null: false
    t.string "status", default: "draft"
    t.text "summary"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["published_at"], name: "index_posts_on_published_at"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
    t.index ["status"], name: "index_posts_on_status"
  end

  create_table "projects", force: :cascade do |t|
    t.string "category"
    t.string "cover_image_alt"
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "destination_id"
    t.integer "duration_weeks_max"
    t.integer "duration_weeks_min"
    t.string "location_name"
    t.jsonb "meta", default: {}
    t.integer "position", default: 0
    t.string "slug", null: false
    t.string "status", default: "active"
    t.text "summary"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_projects_on_category"
    t.index ["destination_id"], name: "index_projects_on_destination_id"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
    t.index ["status"], name: "index_projects_on_status"
  end

  create_table "site_settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "key", null: false
    t.datetime "updated_at", null: false
    t.text "value"
    t.string "value_type", default: "string"
    t.index ["key"], name: "index_site_settings_on_key", unique: true
  end

  create_table "team_members", force: :cascade do |t|
    t.boolean "active", default: true
    t.text "bio"
    t.string "country"
    t.datetime "created_at", null: false
    t.string "department"
    t.string "github_url"
    t.string "linkedin_url"
    t.string "name", null: false
    t.integer "position", default: 0
    t.string "role", null: false
    t.datetime "updated_at", null: false
  end

  create_table "testimonials", force: :cascade do |t|
    t.string "country"
    t.datetime "created_at", null: false
    t.boolean "featured", default: false
    t.string "name", null: false
    t.integer "position", default: 0
    t.bigint "project_id"
    t.text "quote"
    t.string "role"
    t.datetime "updated_at", null: false
    t.string "video_url"
    t.index ["project_id"], name: "index_testimonials_on_project_id"
  end

  create_table "volunteer_applications", force: :cascade do |t|
    t.text "admin_notes"
    t.string "application_type"
    t.datetime "created_at", null: false
    t.date "date_of_birth"
    t.bigint "destination_id"
    t.integer "duration_weeks"
    t.string "email", null: false
    t.text "experience"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.jsonb "meta", default: {}
    t.text "motivation"
    t.string "nationality"
    t.string "phone"
    t.date "preferred_start_date"
    t.bigint "project_id"
    t.text "skills"
    t.string "status", default: "pending"
    t.datetime "updated_at", null: false
    t.index ["application_type"], name: "index_volunteer_applications_on_application_type"
    t.index ["destination_id"], name: "index_volunteer_applications_on_destination_id"
    t.index ["email"], name: "index_volunteer_applications_on_email"
    t.index ["project_id"], name: "index_volunteer_applications_on_project_id"
    t.index ["status"], name: "index_volunteer_applications_on_status"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "posts", "admin_users", column: "author_id"
  add_foreign_key "projects", "destinations"
  add_foreign_key "testimonials", "projects"
  add_foreign_key "volunteer_applications", "destinations"
  add_foreign_key "volunteer_applications", "projects"
end
