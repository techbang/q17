# find system imagemagick command location
if File.exist?('/usr/local/bin/identify') && File.exist?('/usr/local/bin/convert')
  Paperclip.options[:command_path] = '/usr/local/bin'
elsif File.exist?('/usr/bin/identify') && File.exist?('/usr/bin/convert')
  Paperclip.options[:command_path] = '/usr/bin'
end

Paperclip.interpolates :year do |attachment, style|
    attachment.instance.created_at.strftime("%Y")
end

Paperclip.interpolates :month do |attachment, style|
    attachment.instance.created_at.strftime("%m")
end
