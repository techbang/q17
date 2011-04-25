class CreateFollowships < ActiveRecord::Migration
  def self.up
    create_table :followships do |t|
      t.references :target, :polymorphic => true
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :followships
  end
end
