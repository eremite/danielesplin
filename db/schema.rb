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

ActiveRecord::Schema.define(version: 20141017220457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "entries", force: true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.datetime "at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "inventory_item_photos", force: true do |t|
    t.integer  "inventory_item_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inventory_item_photos", ["inventory_item_id"], name: "index_inventory_item_photos_on_inventory_item_id", using: :btree
  add_index "inventory_item_photos", ["photo_id"], name: "index_inventory_item_photos_on_photo_id", using: :btree

  create_table "inventory_items", force: true do |t|
    t.string   "name"
    t.date     "on"
    t.text     "description"
    t.integer  "cost"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log_entries", force: true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "log_entries", ["user_id"], name: "index_log_entries_on_user_id", using: :btree

  create_table "nutritional_posts", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.datetime "published_at"
    t.text     "bite"
    t.text     "full_plate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.datetime "at"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "image"
    t.integer  "entry_id"
    t.boolean  "hidden",           default: false
    t.string   "image_tmp"
    t.boolean  "image_processing"
  end

  add_index "photos", ["entry_id"], name: "index_photos_on_entry_id", using: :btree
  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree

  create_table "post_photos", force: true do |t|
    t.integer  "post_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_photos", ["photo_id"], name: "index_post_photos_on_photo_id", using: :btree
  add_index "post_photos", ["post_id"], name: "index_post_photos_on_post_id", using: :btree

  create_table "posts", force: true do |t|
    t.text     "body"
    t.datetime "at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "saved_file_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "saved_files", force: true do |t|
    t.integer  "user_id"
    t.text     "description"
    t.string   "attachment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "saved_file_category_id"
  end

  add_index "saved_files", ["saved_file_category_id"], name: "index_saved_files_on_saved_file_category_id", using: :btree
  add_index "saved_files", ["user_id"], name: "index_saved_files_on_user_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "thoughts", force: true do |t|
    t.integer  "user_id"
    t.string   "body"
    t.date     "on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thoughts", ["user_id"], name: "index_thoughts_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",            default: "guest"
    t.string   "api_key"
  end

  add_index "users", ["role"], name: "index_users_on_role", using: :btree

end
