class CreateThankingShips < ActiveRecord::Migration
  def self.up
    create_table :thanking_ships do |t|
      t.integer :user_id
      t.integer :answer_id
      t.timestamps
    end
  end

  def self.down
    drop_table :thanking_ships
  end
end
