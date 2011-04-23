class UserCount < ActiveRecord::Migration
  def self.up
    add_column :users, :asks_count , :integer ,:default => 0
  end

  def self.down
    remove_column :users, :asks_count
  end
end
