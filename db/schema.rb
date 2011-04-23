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

ActiveRecord::Schema.define(:version => 20110423114815) do

  create_table "answered_ask_ships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ask_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", :force => true do |t|
    t.text     "body"
    t.integer  "comments_count",   :default => 0
    t.integer  "spams_count",      :default => 0
    t.integer  "spam_voter_ids"
    t.integer  "up_votes_count",   :default => 0
    t.integer  "down_votes_count", :default => 0
    t.integer  "ask_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ask_invites", :force => true do |t|
    t.integer  "ask_id"
    t.integer  "user_id"
    t.integer  "count",       :default => 0
    t.integer  "mail_sent",   :default => 0
    t.string   "invitor_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asks", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "answered_at"
    t.integer  "answers_count",       :default => 0
    t.integer  "comments_count",      :default => 0
    t.string   "topic"
    t.integer  "spams_count",         :default => 0
    t.string   "spam_voter_ids"
    t.integer  "views_count",         :default => 0
    t.datetime "last_updated_at"
    t.integer  "redirect_ask_id"
    t.integer  "user_id"
    t.integer  "last_answer_user_id"
    t.integer  "last_answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "follow_topic_ships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followed_ask_ships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ask_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "muted_ask_ships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ask_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.boolean  "has_read"
    t.integer  "target_id"
    t.string   "action"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",           :limit => 100, :default => ""
    t.string   "gender"
    t.date     "birthday"
    t.string   "age"
    t.string   "hobby"
    t.string   "skill"
    t.string   "education"
    t.string   "job"
    t.string   "income"
    t.string   "preferred_info"
    t.string   "blog_url"
    t.string   "facebook_url"
    t.string   "plurk_url"
    t.string   "twitter_url"
    t.string   "resume"
    t.string   "mobile"
    t.string   "phone"
    t.string   "zip_code"
    t.string   "city"
    t.string   "county"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["birthday"], :name => "index_profiles_on_birthday"
  add_index "profiles", ["city"], :name => "index_profiles_on_city"
  add_index "profiles", ["education"], :name => "index_profiles_on_education"
  add_index "profiles", ["income"], :name => "index_profiles_on_income"
  add_index "profiles", ["job"], :name => "index_profiles_on_job"
  add_index "profiles", ["zip_code"], :name => "index_profiles_on_zip_code"

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.text     "conver"
    t.integer  "asks_count", :default => 0
    t.integer  "ask_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",            :limit => 40
    t.string   "name",             :limit => 100, :default => ""
    t.string   "nickname",         :limit => 40
    t.string   "slug",             :limit => 40
    t.string   "sex"
    t.string   "email",            :limit => 100
    t.integer  "fb_user_id",       :limit => 8
    t.string   "email_hash"
    t.string   "avatar_file_name"
    t.integer  "role_id"
    t.boolean  "is_agreed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "asks_count",                      :default => 0
    t.integer  "answers_count",                   :default => 0
    t.string   "tagline"
  end

  add_index "users", ["fb_user_id"], :name => "index_users_on_fb_user_id"
  add_index "users", ["role_id"], :name => "index_users_on_role_id"

end
