class CreateReportSpams < ActiveRecord::Migration
  def self.up
    create_table :report_spams do |t|
      t.string :url
      t.text   :description
      t.timestamps
    end
  end

  def self.down
    drop_table :report_spams
  end
end
