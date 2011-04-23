class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string     :login,            :limit => 40
      t.string     :name,             :limit => 100, :default => '', :null => true
      t.string     :nickname,         :limit => 40
      t.string     :slug,             :limit => 40
      t.string     :sex
      t.string     :email,            :limit => 100
      t.integer    :fb_user_id,       :limit => 20
      t.string     :email_hash
      t.string     :avatar_file_name
      t.integer    :role_id
      t.boolean    :is_agreed
      t.timestamps
    end

    execute("alter table users modify fb_user_id bigint")
    add_index 'users', 'fb_user_id'
    add_index 'users', 'role_id'
  end

  def self.down
    drop_table :users
  end
end
