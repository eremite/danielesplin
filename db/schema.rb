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

ActiveRecord::Schema[8.1].define(version: 2026_01_20_212545) do
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

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at"
    t.integer "post_id"
    t.datetime "updated_at"
    t.integer "user_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "decider_list_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "decider_list_id"
    t.string "name"
    t.datetime "picked_at"
    t.datetime "updated_at", null: false
    t.index ["decider_list_id"], name: "index_decider_list_items_on_decider_list_id"
  end

  create_table "decider_lists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "entries", force: :cascade do |t|
    t.datetime "at"
    t.text "body"
    t.datetime "created_at"
    t.bigint "creator_id"
    t.datetime "updated_at"
    t.integer "user_id"
    t.index ["creator_id"], name: "index_entries_on_creator_id"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "inventory_item_photos", force: :cascade do |t|
    t.datetime "created_at"
    t.integer "inventory_item_id"
    t.integer "photo_id"
    t.datetime "updated_at"
    t.index ["inventory_item_id"], name: "index_inventory_item_photos_on_inventory_item_id"
    t.index ["photo_id"], name: "index_inventory_item_photos_on_photo_id"
  end

  create_table "inventory_items", force: :cascade do |t|
    t.integer "cost"
    t.datetime "created_at"
    t.datetime "deleted_at"
    t.text "description"
    t.string "name"
    t.date "on"
    t.datetime "updated_at"
    t.integer "value"
  end

  create_table "log_entries", force: :cascade do |t|
    t.string "action"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.index ["user_id"], name: "index_log_entries_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "finished_at"
    t.string "kind"
    t.text "meta"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.datetime "at"
    t.datetime "created_at"
    t.text "description"
    t.integer "entry_id"
    t.boolean "hidden", default: false
    t.string "image"
    t.boolean "image_processing"
    t.string "image_tmp"
    t.datetime "updated_at"
    t.integer "user_id"
    t.index ["entry_id"], name: "index_photos_on_entry_id"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "post_photos", force: :cascade do |t|
    t.datetime "created_at"
    t.integer "photo_id"
    t.integer "post_id"
    t.datetime "updated_at"
    t.index ["photo_id"], name: "index_post_photos_on_photo_id"
    t.index ["post_id"], name: "index_post_photos_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "at"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.string "context", limit: 128
    t.datetime "created_at"
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "api_key"
    t.datetime "born_at"
    t.datetime "created_at"
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "role", default: "guest"
    t.datetime "updated_at"
    t.datetime "viewed_blog_at"
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "entries", "users", column: "creator_id"
end
