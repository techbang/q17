class ReportSpam < ActiveRecord::Base
    include BaseModel

    def self.add(url, description, user_name)
      report = self.new(:url => url )
      report.description = "#{user_name}:\n#{description}"
      report.save
    end
end
