class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :name
      t.text   :summary
      t.text   :conver
      t.integer :asks_count, :default => 0
      t.integer :ask_id
      t.string  :cover, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
