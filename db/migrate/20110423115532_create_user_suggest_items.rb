class CreateUserSuggestItems < ActiveRecord::Migration
  def self.up
    create_table :user_suggest_items do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :user_suggest_items
  end
end
