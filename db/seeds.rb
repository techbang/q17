# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

TEST_ACCOUNT = ["xdite"]
puts "create user"
TEST_ACCOUNT.each do |account|
  u = User.create(:login => account, :name => account, :nickname => account, :slug => account )
  u.save
end



ask = Ask.new(:title => "ask-title-1", :body => "ask-body-1")
ask.user_id = 1
ask.current_user_id = 1
ask.save!

topic = Topic.new(:name => "topic-1", :summary => "summary-1")
topic.ask_id = 1
topic.save

ask.update_topics("Apple", true, 1)
ask.update_topics("Apple", false, 1)