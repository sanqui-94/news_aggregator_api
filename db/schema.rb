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

ActiveRecord::Schema[8.1].define(version: 2026_03_04_175140) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "articles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "external_id", null: false
    t.datetime "published_at", null: false
    t.bigint "source_id", null: false
    t.text "summary"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.string "url", null: false
    t.index ["source_id", "external_id"], name: "index_articles_on_source_id_and_external_id", unique: true
    t.index ["source_id", "published_at"], name: "index_articles_on_source_id_and_published_at"
  end

  create_table "default_feed_sources", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "source_id", null: false
    t.index ["source_id"], name: "index_default_feed_sources_on_source_id", unique: true
  end

  create_table "feed_sources", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "feed_id", null: false
    t.bigint "source_id", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id", "source_id"], name: "index_feed_sources_on_feed_id_and_source_id", unique: true
    t.index ["feed_id"], name: "index_feed_sources_on_feed_id"
    t.index ["source_id"], name: "index_feed_sources_on_source_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_feeds_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "data", default: {}, null: false
    t.boolean "read", default: false, null: false
    t.string "type", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "read"], name: "index_notifications_on_user_id_and_read"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "source_suggestions", force: :cascade do |t|
    t.text "admin_notes"
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.datetime "reviewed_at"
    t.bigint "reviewed_by_id"
    t.string "status", default: "pending", null: false
    t.datetime "updated_at", null: false
    t.string "url", null: false
    t.bigint "user_id"
    t.index ["reviewed_by_id"], name: "index_source_suggestions_on_reviewed_by_id"
    t.index ["status"], name: "index_source_suggestions_on_status"
    t.index ["user_id"], name: "index_source_suggestions_on_user_id"
  end

  create_table "source_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "source_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "updated_at", null: false
    t.index ["source_id", "tag_id"], name: "index_source_tags_on_source_id_and_tag_id", unique: true
    t.index ["source_id"], name: "index_source_tags_on_source_id"
    t.index ["tag_id"], name: "index_source_tags_on_tag_id"
  end

  create_table "sources", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.datetime "last_fetched_at"
    t.string "name", null: false
    t.string "site_url"
    t.datetime "updated_at", null: false
    t.string "url", null: false
    t.index ["url"], name: "index_sources_on_url", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
    t.index ["slug"], name: "index_tags_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.string "provider", null: false
    t.string "role", default: "user", null: false
    t.string "uid", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
  end

  add_foreign_key "articles", "sources", on_delete: :cascade
  add_foreign_key "default_feed_sources", "sources", on_delete: :cascade
  add_foreign_key "feed_sources", "feeds", on_delete: :cascade
  add_foreign_key "feed_sources", "sources", on_delete: :cascade
  add_foreign_key "feeds", "users", on_delete: :cascade
  add_foreign_key "notifications", "users", on_delete: :cascade
  add_foreign_key "source_suggestions", "users", column: "reviewed_by_id", on_delete: :nullify
  add_foreign_key "source_suggestions", "users", on_delete: :nullify
  add_foreign_key "source_tags", "sources", on_delete: :cascade
  add_foreign_key "source_tags", "tags", on_delete: :restrict
end
