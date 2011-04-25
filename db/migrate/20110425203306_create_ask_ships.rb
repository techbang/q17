class CreateAskShips < ActiveRecord::Migration
  def self.up
    create_table :ask_ships do |t|
      t.integer :ask_id
      t.integer :user_id
      t.string  :type
      t.timestamps
    end
  end

  def self.down
    drop_table :ask_ships
  end
end
