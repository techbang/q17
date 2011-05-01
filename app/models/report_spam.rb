class ReportSpam < ActiveRecord::Base
    include BaseModel

    def self.add(url, description, user_name)
      report = self.new(:url => url )
      report.description = "#{user_name}:\n#{description}"
      report.save
    end
end

# == Schema Information
#
# Table name: report_spams
#
#  id          :integer(4)      not null, primary key
#  url         :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

