class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|
      t.string :title
      t.string :target_attr
      t.string :action
      t.text   :diff
      t.integer :target_id
      t.string  :target_parent_title
      t.integer :user_id
      t.string  :type
      t.string  :resource_type
      t.string  :resource_id
      t.timestamps
    end
  end

  def self.down
    drop_table :logs
  end
end
