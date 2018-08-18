# namespace :move_file do
#   desc "move upload file"
#   task :avatar => :environment do |task, args|
#     Page.ne(avatar: nil).each do |page|
#       path = "#{Rails.root}/public/uploads/avatar/#{page.created_at.strftime("%Y%m")}"
#       FileUtils.mkdir(path) unless File.directory?(path)
#       file = page.avatar.path
#       begin
#         FileUtils.cp(file, "#{path}/#{ File.basename(file)}")
#       rescue Exception => e
#         p e.message
#         #p e.backtrace.inspect
#       ensure
#
#       end
#     end
#   end
# end
