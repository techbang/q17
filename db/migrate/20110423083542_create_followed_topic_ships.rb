class CreateFollowedTopicShips < ActiveRecord::Migration
  def self.up
    create_table :followed_topic_ships do |t|
      t.integer :user_id
      t.integer :topic_id
      t.timestamps
    end
  end

  def self.down
    drop_table :follow_topic_ships
  end
end
