class CreateTimeEntries < ActiveRecord::Migration
  def self.up
    create_table :time_entries do |t|
      t.integer :creator_id
      t.string  :resource_type
      t.integer  :resource_id
      t.string  :target_type
      t.integer :target_id
      t.string  :type
      t.string  :action
      t.timestamps
    end
  end

  def self.down
    drop_table :time_entries
  end
end
