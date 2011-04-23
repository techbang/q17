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

ActiveRecord::Schema.define(:version => 20110423042155) do

  create_table "users", :force => true do |t|
    t.string   "login",            :limit => 40
    t.string   "name",             :limit => 100, :default => ""
    t.string   "nickname",         :limit => 40
    t.string   "email",            :limit => 100
    t.integer  "fb_user_id",       :limit => 8
    t.string   "email_hash"
    t.string   "avatar_file_name"
    t.integer  "role_id"
    t.boolean  "is_agreed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["fb_user_id"], :name => "index_users_on_fb_user_id"
  add_index "users", ["role_id"], :name => "index_users_on_role_id"

end
