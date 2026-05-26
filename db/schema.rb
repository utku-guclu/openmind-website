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

ActiveRecord::Schema[8.1].define(version: 2026_05_25_120200) do
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

  create_table "audience_activity_bullets", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.integer "position", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "volunteer_audience_id", null: false
    t.index ["volunteer_audience_id", "position"], name: "idx_on_volunteer_audience_id_position_0460c70966"
    t.index ["volunteer_audience_id"], name: "index_audience_activity_bullets_on_volunteer_audience_id"
  end

  create_table "audience_benefits", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "icon"
    t.integer "position", default: 0, null: false
    t.text "text"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "volunteer_audience_id", null: false
    t.index ["volunteer_audience_id", "position"], name: "index_audience_benefits_on_volunteer_audience_id_and_position"
    t.index ["volunteer_audience_id"], name: "index_audience_benefits_on_volunteer_audience_id"
  end

  create_table "audience_bond_sections", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "heading"
    t.integer "position", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "volunteer_audience_id", null: false
    t.index ["volunteer_audience_id", "position"], name: "idx_on_volunteer_audience_id_position_225facddbf"
    t.index ["volunteer_audience_id"], name: "index_audience_bond_sections_on_volunteer_audience_id"
  end

  create_table "audience_faqs", force: :cascade do |t|
    t.text "answer"
    t.datetime "created_at", null: false
    t.integer "position", default: 0, null: false
    t.string "question", null: false
    t.datetime "updated_at", null: false
    t.bigint "volunteer_audience_id", null: false
    t.index ["volunteer_audience_id", "position"], name: "index_audience_faqs_on_volunteer_audience_id_and_position"
    t.index ["volunteer_audience_id"], name: "index_audience_faqs_on_volunteer_audience_id"
  end

  create_table "audience_gallery_images", force: :cascade do |t|
    t.string "alt"
    t.datetime "created_at", null: false
    t.string "image_url", comment: "Fallback URL when no file is attached"
    t.integer "position", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "volunteer_audience_id", null: false
    t.index ["volunteer_audience_id", "position"], name: "idx_on_volunteer_audience_id_position_1298e5b3c7"
    t.index ["volunteer_audience_id"], name: "index_audience_gallery_images_on_volunteer_audience_id"
  end

  create_table "audience_intro_sections", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "heading"
    t.integer "position", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "volunteer_audience_id", null: false
    t.index ["volunteer_audience_id", "position"], name: "idx_on_volunteer_audience_id_position_c1766f326f"
    t.index ["volunteer_audience_id"], name: "index_audience_intro_sections_on_volunteer_audience_id"
  end

  create_table "audience_journey_steps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "position", default: 0, null: false
    t.string "step_label"
    t.text "text"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "volunteer_audience_id", null: false
    t.index ["volunteer_audience_id", "position"], name: "idx_on_volunteer_audience_id_position_e311a922a7"
    t.index ["volunteer_audience_id"], name: "index_audience_journey_steps_on_volunteer_audience_id"
  end

  create_table "audience_videos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "duration"
    t.integer "position", default: 0, null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "volunteer_audience_id", null: false
    t.string "youtube_id", null: false
    t.index ["volunteer_audience_id", "position"], name: "index_audience_videos_on_volunteer_audience_id_and_position"
    t.index ["volunteer_audience_id"], name: "index_audience_videos_on_volunteer_audience_id"
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
    t.string "hero_image_url"
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

  create_table "locations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "destination_id", null: false
    t.decimal "latitude", precision: 10, scale: 7
    t.decimal "longitude", precision: 10, scale: 7
    t.string "name", null: false
    t.integer "position", default: 0
    t.string "region"
    t.string "slug", null: false
    t.string "status", default: "active"
    t.text "summary"
    t.datetime "updated_at", null: false
    t.index ["destination_id"], name: "index_locations_on_destination_id"
    t.index ["slug"], name: "index_locations_on_slug", unique: true
    t.index ["status"], name: "index_locations_on_status"
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
    t.bigint "location_id"
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
    t.index ["location_id"], name: "index_projects_on_location_id"
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

  create_table "solid_cable_messages", force: :cascade do |t|
    t.binary "channel", null: false
    t.bigint "channel_hash", null: false
    t.datetime "created_at", null: false
    t.binary "payload", null: false
    t.index ["channel"], name: "index_solid_cable_messages_on_channel"
    t.index ["channel_hash"], name: "index_solid_cable_messages_on_channel_hash"
    t.index ["created_at"], name: "index_solid_cable_messages_on_created_at"
  end

  create_table "solid_cache_entries", force: :cascade do |t|
    t.integer "byte_size", null: false
    t.datetime "created_at", null: false
    t.binary "key", null: false
    t.bigint "key_hash", null: false
    t.binary "value", null: false
    t.index ["byte_size"], name: "index_solid_cache_entries_on_byte_size"
    t.index ["key_hash", "byte_size"], name: "index_solid_cache_entries_on_key_hash_and_byte_size"
    t.index ["key_hash"], name: "index_solid_cache_entries_on_key_hash", unique: true
  end

  create_table "solid_queue_blocked_executions", force: :cascade do |t|
    t.string "concurrency_key", null: false
    t.datetime "created_at", null: false
    t.datetime "expires_at", null: false
    t.bigint "job_id", null: false
    t.integer "priority", default: 0, null: false
    t.string "queue_name", null: false
    t.index ["concurrency_key", "priority", "job_id"], name: "index_solid_queue_blocked_executions_for_release"
    t.index ["expires_at", "concurrency_key"], name: "index_solid_queue_blocked_executions_for_maintenance"
    t.index ["job_id"], name: "index_solid_queue_blocked_executions_on_job_id", unique: true
  end

  create_table "solid_queue_claimed_executions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.bigint "process_id"
    t.index ["job_id"], name: "index_solid_queue_claimed_executions_on_job_id", unique: true
    t.index ["process_id", "job_id"], name: "index_solid_queue_claimed_executions_on_process_id_and_job_id"
  end

  create_table "solid_queue_failed_executions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "error"
    t.bigint "job_id", null: false
    t.index ["job_id"], name: "index_solid_queue_failed_executions_on_job_id", unique: true
  end

  create_table "solid_queue_jobs", force: :cascade do |t|
    t.string "active_job_id"
    t.text "arguments"
    t.string "class_name", null: false
    t.string "concurrency_key"
    t.datetime "created_at", null: false
    t.datetime "finished_at"
    t.integer "priority", default: 0, null: false
    t.string "queue_name", null: false
    t.datetime "scheduled_at"
    t.datetime "updated_at", null: false
    t.index ["active_job_id"], name: "index_solid_queue_jobs_on_active_job_id"
    t.index ["class_name"], name: "index_solid_queue_jobs_on_class_name"
    t.index ["finished_at"], name: "index_solid_queue_jobs_on_finished_at"
    t.index ["queue_name", "finished_at"], name: "index_solid_queue_jobs_for_filtering"
    t.index ["scheduled_at", "finished_at"], name: "index_solid_queue_jobs_for_alerting"
  end

  create_table "solid_queue_pauses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "queue_name", null: false
    t.index ["queue_name"], name: "index_solid_queue_pauses_on_queue_name", unique: true
  end

  create_table "solid_queue_processes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "hostname"
    t.string "kind", null: false
    t.datetime "last_heartbeat_at", null: false
    t.text "metadata"
    t.string "name", null: false
    t.integer "pid", null: false
    t.bigint "supervisor_id"
    t.index ["last_heartbeat_at"], name: "index_solid_queue_processes_on_last_heartbeat_at"
    t.index ["name", "supervisor_id"], name: "index_solid_queue_processes_on_name_and_supervisor_id", unique: true
    t.index ["supervisor_id"], name: "index_solid_queue_processes_on_supervisor_id"
  end

  create_table "solid_queue_ready_executions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.integer "priority", default: 0, null: false
    t.string "queue_name", null: false
    t.index ["job_id"], name: "index_solid_queue_ready_executions_on_job_id", unique: true
    t.index ["priority", "job_id"], name: "index_solid_queue_poll_all"
    t.index ["queue_name", "priority", "job_id"], name: "index_solid_queue_poll_by_queue"
  end

  create_table "solid_queue_recurring_executions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.datetime "run_at", null: false
    t.string "task_key", null: false
    t.index ["job_id"], name: "index_solid_queue_recurring_executions_on_job_id", unique: true
    t.index ["task_key", "run_at"], name: "index_solid_queue_recurring_executions_on_task_key_and_run_at", unique: true
  end

  create_table "solid_queue_recurring_tasks", force: :cascade do |t|
    t.text "arguments"
    t.string "class_name"
    t.string "command", limit: 2048
    t.datetime "created_at", null: false
    t.text "description"
    t.string "key", null: false
    t.integer "priority", default: 0
    t.string "queue_name"
    t.string "schedule", null: false
    t.boolean "static", default: true, null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_solid_queue_recurring_tasks_on_key", unique: true
    t.index ["static"], name: "index_solid_queue_recurring_tasks_on_static"
  end

  create_table "solid_queue_scheduled_executions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.integer "priority", default: 0, null: false
    t.string "queue_name", null: false
    t.datetime "scheduled_at", null: false
    t.index ["job_id"], name: "index_solid_queue_scheduled_executions_on_job_id", unique: true
    t.index ["scheduled_at", "priority", "job_id"], name: "index_solid_queue_dispatch_all"
  end

  create_table "solid_queue_semaphores", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at", null: false
    t.string "key", null: false
    t.datetime "updated_at", null: false
    t.integer "value", default: 1, null: false
    t.index ["expires_at"], name: "index_solid_queue_semaphores_on_expires_at"
    t.index ["key", "value"], name: "index_solid_queue_semaphores_on_key_and_value"
    t.index ["key"], name: "index_solid_queue_semaphores_on_key", unique: true
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

  create_table "volunteer_audiences", force: :cascade do |t|
    t.text "activity_intro"
    t.jsonb "content", default: {}, null: false
    t.datetime "created_at", null: false
    t.string "cta_text", default: "Apply Today"
    t.string "duration"
    t.string "hero_image_object_fit", default: "cover"
    t.string "hero_image_object_position", default: "center"
    t.string "hero_image_url"
    t.string "hero_video_id"
    t.string "icon"
    t.text "intro"
    t.string "name", null: false
    t.text "podcast_deepdive_description"
    t.string "podcast_deepdive_title"
    t.string "podcast_url"
    t.integer "position", default: 0
    t.string "slug", null: false
    t.string "status", default: "active"
    t.text "subtitle"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["position"], name: "index_volunteer_audiences_on_position"
    t.index ["slug"], name: "index_volunteer_audiences_on_slug", unique: true
    t.index ["status"], name: "index_volunteer_audiences_on_status"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "audience_activity_bullets", "volunteer_audiences"
  add_foreign_key "audience_benefits", "volunteer_audiences"
  add_foreign_key "audience_bond_sections", "volunteer_audiences"
  add_foreign_key "audience_faqs", "volunteer_audiences"
  add_foreign_key "audience_gallery_images", "volunteer_audiences"
  add_foreign_key "audience_intro_sections", "volunteer_audiences"
  add_foreign_key "audience_journey_steps", "volunteer_audiences"
  add_foreign_key "audience_videos", "volunteer_audiences"
  add_foreign_key "locations", "destinations"
  add_foreign_key "posts", "admin_users", column: "author_id"
  add_foreign_key "projects", "destinations"
  add_foreign_key "projects", "locations"
  add_foreign_key "solid_queue_blocked_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_claimed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_failed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_ready_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_recurring_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_scheduled_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "testimonials", "projects"
  add_foreign_key "volunteer_applications", "destinations"
  add_foreign_key "volunteer_applications", "projects"
end
