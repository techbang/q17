namespace :dev do

  desc "Rebuild system"
  task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", "db:seed" ]
end
namespace :cache do
  desc 'Clear memcache'
  task :clear => :environment do
    ActionController::Base.cache_store.clear
  end
end
