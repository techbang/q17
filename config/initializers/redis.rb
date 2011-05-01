require 'redis'
require 'redis/text_search'
require 'redis/objects'
path = "#{Rails.root}/config/redis.yml"

if File.exist?(path)
  file = File.read(path)
  config = YAML.load(file)[Rails.env]

  redis_host = config["host"]
  redis_port = config["port"]
  db_number  = config["db"]

  if redis_host.present? && redis_port.present? && db_number.present?
    Redis::Objects.redis = Redis.new(:host => redis_host, :port => redis_port, :db => db_number)
    Redis::TextSearch.redis = Redis.new(:host => 'localhost', :port => 6379)
  else
    puts "Incorrect redis config - #{path} (#{Rails.env})"
  end
else
  puts "No redis config - #{path} (#{Rails.env})"
end
