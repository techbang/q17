# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

TEST_ACCOUNT = ["xdite", "v13"]
puts "create user"
TEST_ACCOUNT.each do |account|
  u = User.create(:login => account, :name => account, :nickname => account, :slug => account )
  u.save
end

user1 = User.find(1)
user2 = User.find(2)

ask = Ask.new(:title => "ask-title-1", :body => "ask-body-1")
ask.user_id = 1
ask.current_user_id = 1
ask.save!

comment1 = Comment.new(:body => "comment-1")
comment1.commentable_type = "Ask"
comment1.commentable_id = 1
comment1.user_id = 1
comment1.save!

topic1 = Topic.new(:name => "topic-1", :summary => "summary-1")
topic1.ask_id = 1
topic1.save

answer1 = Answer.new(:body => "answer-1")
answer1.ask_id = 1
answer1.user_id = 1
answer1.save

comment2 = Comment.new(:body => "comment-1")
comment2.commentable_type = "Answer"
comment2.commentable_id = 1
comment2.user_id = 1
comment2.save!

ask.update_topics("Apple", true, 1)
ask.update_topics("Apple", false, 1)

user1.follow(user2)
user1.unfollow(user2)
user1.follow_topic(topic1)
user1.unfollow_topic(topic1)
user1.follow_ask(ask)
user1.unfollow_ask(ask)
#user1.follow_answer(answer1)
#user1.unfollow_answer(answer1)