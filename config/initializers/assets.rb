# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

Rails.application.config.assets.precompile += %w(admin.css admin.js login.js */*.jpg)
Rails.application.config.assets.precompile += %w(ckeditor/config.js)
Rails.application.config.assets.precompile += %w( ckeditor/filebrowser/images/gal_del.png )
#Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
#Rails.application.config.assets.precompile += %w( sites/*/assets/* )

Dir.glob("#{Rails.root}/app/sites/*/assets/*").each do |dir|
  Rails.application.config.assets.paths << dir
end

# Dir.glob("#{Rails.root}/app/sites/*/assets/*.*").each do |file|
#    basename = file.split('/').last
#    Rails.application.config.assets.precompile <<  basename
# end

# This will precompile any assets, not just JavaScript (.js, .coffee, .swf, .css, .scss)
Rails.application.config.assets.precompile << Proc.new do |path|
  name = File.basename(path)
  content_type = MIME::Types.type_for(name).first.content_type rescue ""
  res = false
  if (path =~ /\.(css|js|svg|ttf|woff|eot|swf|pdf)\z/ || content_type.scan(/(css|javascript|image\/|audio|video|font)/).any?) && !name.start_with?("_") && !path.include?('/views/')
    res = true
  end
  res
end
