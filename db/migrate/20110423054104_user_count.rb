class UserCount < ActiveRecord::Migration
  def self.up
    add_column :users, :asks_count , :integer ,:default => 0
    add_column :users, :answers_count, :integer, :default => 0
    add_column :users, :tagline, :string

    
  end

  def self.down
    remove_column :users, :asks_count
    remove_column :users, :muted_ask_ids
    remove_column :users, :tagline

  end
end
