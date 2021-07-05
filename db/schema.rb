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

ActiveRecord::Schema.define(version: 2021_06_30_141609) do

  create_table "comments", charset: "utf8", force: :cascade do |t|
    t.integer "user_id"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "post_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "decider_list_items", charset: "utf8", force: :cascade do |t|
    t.integer "decider_list_id"
    t.string "name"
    t.datetime "picked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["decider_list_id"], name: "index_decider_list_items_on_decider_list_id"
  end

  create_table "decider_lists", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entries", charset: "utf8", force: :cascade do |t|
    t.integer "user_id"
    t.text "body"
    t.datetime "at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "inventory_item_photos", charset: "utf8", force: :cascade do |t|
    t.integer "inventory_item_id"
    t.integer "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["inventory_item_id"], name: "index_inventory_item_photos_on_inventory_item_id"
    t.index ["photo_id"], name: "index_inventory_item_photos_on_photo_id"
  end

  create_table "inventory_items", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.date "on"
    t.text "description"
    t.integer "cost"
    t.integer "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log_entries", charset: "utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "action"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_log_entries_on_user_id"
  end

  create_table "notes", charset: "utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "finished_at"
    t.string "kind"
    t.text "meta"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "photos", charset: "utf8", force: :cascade do |t|
    t.datetime "at"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "image"
    t.integer "entry_id"
    t.boolean "hidden", default: false
    t.string "image_tmp"
    t.boolean "image_processing"
    t.index ["entry_id"], name: "index_photos_on_entry_id"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "post_photos", charset: "utf8", force: :cascade do |t|
    t.integer "post_id"
    t.integer "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["photo_id"], name: "index_post_photos_on_photo_id"
    t.index ["post_id"], name: "index_post_photos_on_post_id"
  end

  create_table "posts", charset: "utf8", force: :cascade do |t|
    t.text "body"
    t.datetime "at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "saved_file_categories", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "saved_files", charset: "utf8", force: :cascade do |t|
    t.integer "user_id"
    t.text "description"
    t.string "attachment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "saved_file_category_id"
    t.index ["saved_file_category_id"], name: "index_saved_files_on_saved_file_category_id"
    t.index ["user_id"], name: "index_saved_files_on_user_id"
  end

  create_table "taggings", charset: "utf8", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  end

  create_table "tags", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "role", default: "guest"
    t.string "api_key"
    t.datetime "viewed_blog_at"
    t.datetime "born_at"
    t.index ["role"], name: "index_users_on_role"
  end

end
