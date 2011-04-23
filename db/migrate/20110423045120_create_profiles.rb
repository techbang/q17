class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles, :options => 'default charset=utf8' do |t|
      t.references :user
      t.string :name, :limit => 100, :default => '', :null => true
      t.string :gender
      t.date :birthday
      t.string :age
      t.string :hobby
      t.string :skill
      t.string :education
      t.string :job
      t.string :income
      t.string :preferred_info
      t.string :blog_url
      t.string :facebook_url
      t.string :plurk_url
      t.string :twitter_url
      t.string :resume
      t.string :mobile
      t.string :phone
      t.string :zip_code
      t.string :city
      t.string :county
      t.string :address

      t.timestamps
    end

    add_index :profiles, :birthday
    add_index :profiles, :city
    add_index :profiles, :zip_code
    add_index :profiles, :education
    add_index :profiles, :job
    add_index :profiles, :income

    users = User.all
    users.each do |user|
      user.build_profile if user.profile.nil?
      user.profile.name   = user.name  unless user.name.blank?
      user.profile.gender = user.sex   unless user.sex.blank?
      user.profile.age    = user.age   unless user.age.blank?
      user.profile.job    = user.job   unless user.job.blank?
      user.profile.hobby  = user.hobby unless user.hobby.blank?
      user.profile.skill  = user.skill unless user.skill.blank?
      user.save :validate => false
    end
    puts "==== total: #{users.size} ===="
  end

  def self.down
    drop_table :profiles
  end
end