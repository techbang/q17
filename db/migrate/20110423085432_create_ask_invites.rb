class CreateAskInvites < ActiveRecord::Migration
  def self.up
    create_table :ask_invites do |t|
      t.integer :ask_id
      t.integer :user_id
      t.integer :count , :default => 0
      t.integer :mail_sent, :default => 0
      t.integer :be_invitor_id
      t.timestamps
    end
  end

  def self.down
    drop_table :ask_invites
  end
end
