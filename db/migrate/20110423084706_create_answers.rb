class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.text  :body
      t.integer :comments_count, :default => 0
      t.integer :spams_count , :default => 0
      t.integer :spam_voter_ids
      t.integer :up_votes, :default => 0
      t.integer :down_votes, :default => 0
      t.integer :ask_id
      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
