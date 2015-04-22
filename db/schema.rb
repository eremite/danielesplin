# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150422035724) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.text     "body",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id",    limit: 4
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "entries", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.text     "body",       limit: 65535
    t.datetime "at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "inventory_item_photos", force: :cascade do |t|
    t.integer  "inventory_item_id", limit: 4
    t.integer  "photo_id",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inventory_item_photos", ["inventory_item_id"], name: "index_inventory_item_photos_on_inventory_item_id", using: :btree
  add_index "inventory_item_photos", ["photo_id"], name: "index_inventory_item_photos_on_photo_id", using: :btree

  create_table "inventory_items", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.date     "on"
    t.text     "description", limit: 65535
    t.integer  "cost",        limit: 4
    t.integer  "value",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log_entries", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "action",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "log_entries", ["user_id"], name: "index_log_entries_on_user_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "title",       limit: 255
    t.text     "body",        limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.datetime "finished_at"
    t.string   "kind",        limit: 255
  end

  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.datetime "at"
    t.text     "description",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",          limit: 4
    t.string   "image",            limit: 255
    t.integer  "entry_id",         limit: 4
    t.boolean  "hidden",           limit: 1,     default: false
    t.string   "image_tmp",        limit: 255
    t.boolean  "image_processing", limit: 1
  end

  add_index "photos", ["entry_id"], name: "index_photos_on_entry_id", using: :btree
  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree

  create_table "post_photos", force: :cascade do |t|
    t.integer  "post_id",    limit: 4
    t.integer  "photo_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_photos", ["photo_id"], name: "index_post_photos_on_photo_id", using: :btree
  add_index "post_photos", ["post_id"], name: "index_post_photos_on_post_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.text     "body",       limit: 65535
    t.datetime "at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "saved_file_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "saved_files", force: :cascade do |t|
    t.integer  "user_id",                limit: 4
    t.text     "description",            limit: 65535
    t.string   "attachment",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "saved_file_category_id", limit: 4
  end

  add_index "saved_files", ["saved_file_category_id"], name: "index_saved_files_on_saved_file_category_id", using: :btree
  add_index "saved_files", ["user_id"], name: "index_saved_files_on_user_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "thoughts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "body",       limit: 255
    t.date     "on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thoughts", ["user_id"], name: "index_thoughts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",            limit: 255, default: "guest"
    t.string   "api_key",         limit: 255
    t.datetime "viewed_blog_at"
  end

  add_index "users", ["role"], name: "index_users_on_role", using: :btree

  add_foreign_key "notes", "users"
end
