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

ActiveRecord::Schema.define(:version => 20110501124251) do

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
    t.integer  "count",         :default => 0
    t.integer  "mail_sent",     :default => 0
    t.integer  "be_invitor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ask_ships", :force => true do |t|
    t.integer  "ask_id"
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asks", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "answered_at"
    t.integer  "answers_count",       :default => 0
    t.integer  "comments_count",      :default => 0
    t.integer  "to_user_id"
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

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "followships", :force => true do |t|
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", :force => true do |t|
    t.string   "title"
    t.string   "target_attr"
    t.string   "action"
    t.text     "diff"
    t.integer  "target_id"
    t.string   "target_parent_title"
    t.integer  "user_id"
    t.string   "type"
    t.string   "resource_type"
    t.string   "resource_id"
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

  create_table "report_spams", :force => true do |t|
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.text     "conver"
    t.integer  "asks_count",         :default => 0
    t.integer  "ask_id"
    t.string   "string"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.datetime "created_at"
  end

  create_table "thanking_ships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_entries", :force => true do |t|
    t.integer  "creator_id"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "target_type"
    t.integer  "target_id"
    t.string   "type"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_logs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_suggest_items", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",               :limit => 40
    t.string   "name",                :limit => 100, :default => ""
    t.string   "nickname",            :limit => 40
    t.string   "slug",                :limit => 40
    t.string   "sex"
    t.string   "email",               :limit => 100
    t.integer  "fb_user_id",          :limit => 8
    t.string   "email_hash"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "role_id"
    t.boolean  "is_agreed"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "asks_count",                         :default => 0
    t.integer  "answers_count",                      :default => 0
    t.string   "tagline"
  end

  add_index "users", ["fb_user_id"], :name => "index_users_on_fb_user_id"
  add_index "users", ["role_id"], :name => "index_users_on_role_id"

  create_table "votes", :force => true do |t|
    t.boolean  "vote",          :default => false
    t.integer  "voteable_id",                      :null => false
    t.string   "voteable_type",                    :null => false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "fk_voteables"
  add_index "votes", ["voter_id", "voter_type"], :name => "fk_voters"

end
