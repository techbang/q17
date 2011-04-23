class CreateAsks < ActiveRecord::Migration
  def self.up
    create_table :asks do |t|
      t.string :title
      t.text   :body
      t.datetime  :answered_at
      t.integer   :answers_count , :default => 0
      t.integer   :comments_count, :default => 0
      t.string    :topic # Array
      t.integer   :spams_count, :default => 0
      t.string    :spam_voter_ids # Array
      t.integer   :views_count , :default => 0
      t.datetime  :last_updated_at
      t.integer   :redirect_ask_id
      t.integer   :user_id
      t.integer   :last_answer_user_id
      t.integer   :last_answer_id
      t.timestamps
    end
  end

  def self.down
    drop_table :asks
  end
end
