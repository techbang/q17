class CreateTimeLogs < ActiveRecord::Migration
  def self.up
    create_table :time_logs do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :time_logs
  end
end
