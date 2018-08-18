module Xmt
  module Asset
    class Image
      include ActiveModel::Model
      attr_accessor :full_path, :type, :name, :ctime, :size, :image_url, :id

      def self.all(path)
        @images = []
        traverse_image_dir(path)
        @images.sort_by {|i| i.type}
      end

      def self.traverse_image_dir(path)
        FileUtils.mkdir_p(path) unless File.exists?(path)
        Dir.foreach(path) do |file|
          next if file =="."
          next if file ==".."
          full_path = File.join(path, file)
          if File.directory?(full_path)
            @images << new(name: file, size: nil, ctime: nil, type: :dir, full_path: full_path, id: @images.size+1, image_url: nil)
          else
            file_stat = File.stat(full_path)
            @images << new(name: file, size: file_stat.size, ctime: file_stat.ctime.strftime("%Y-%m-%d"), type: :file, full_path: full_path, id: @images.size+1, image_url: make_image_url(full_path))
          end
        end
      end

      def self.image_upload(pics,file_path)
        result=""
        pics.each do |pic|
          file_type = file_ext(pic)
          if extension_white_list.include?(file_type)
            File.open(File.join(file_path, pic.original_filename), "wb") {|f| f.write(pic.read)}
            result += "<p>#{pic.original_filename}上传成功<p>"
          else
            result+= "<p>#{pic.original_filename}格式不正确<p>";
          end
        end
        result
      end

      def self.delete(filepath)
        if File.exist?(filepath)
          return FileUtils.rm_rf(filepath)
        else
          return false
        end
      end

      def self.unzip_file(file,filepath)
        if file_ext(file)=="zip"
          FileUtils.mkdir_p(filepath) unless File.exist?(filepath)
          begin
            Zip::File.open(file.path) do |zif_file|
              zif_file.each do |entry|
                if entry::ftype.to_s == 'file'
                  if File::exists?(File.join(filepath, entry::name))
                    File.delete(File.join(filepath, entry::name))
                  end
                end
                zif_file.extract(entry,File.join(filepath, entry::name)){true}
              end
            end
            {state:true,message:"文件上传成功"}
          rescue
            {state:false,message:"文件解压失败"}
          end
        else
          {state:false,message:"文件格式错误,请上传zip格式文件"}
        end
      end

      def self.file_ext(file)
        file.original_filename.split(".").last
      end

      def self.extension_white_list
        %w(jpg jpeg gif png)
      end

      def self.make_image_url(file_path)
        arr = file_path.split("/").drop(5).join("/")
      end
    end
  end
end

