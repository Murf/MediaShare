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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111216062426) do

  create_table "media", :force => true do |t|
    t.string   "title"
    t.integer  "type"
    t.string   "genre"
    t.integer  "imdb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mediafiles", :force => true do |t|
    t.string   "filename"
    t.string   "relativepath"
    t.integer  "remote_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "media_id"
  end

  add_index "mediafiles", ["remote_id"], :name => "index_mediafiles_on_remote_id"
  add_index "mediafiles", ["user_id"], :name => "index_mediafiles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "hashed_password"
    t.string   "salt"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
