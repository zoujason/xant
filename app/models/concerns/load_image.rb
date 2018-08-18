class LoadImage
      def self.upload(file)
        if !file.original_filename.empty?  #file.original_filename 获取文件名字
          filename = CGI::escape(file.original_filename)
          FileUtils.mkdir("#{Rails.root}/public/upload") unless File.exists?("#{Rails.root}/public/upload")
          #wb 表示通过二进制方式写，可以保证文件不损坏
          File.open("#{Rails.root}/public/upload/#{filename}", "wb") do |f|
            f.write(file.read)
          end
          path = "/upload/#{filename}"
        end
      end
    end