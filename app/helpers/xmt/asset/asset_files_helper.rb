module Xmt
  module Asset
    module AssetFilesHelper

      def all(path)
        files = []
        if File.directory?(path)
          file_dir = Dir.open(path)
          file_dir.each do |file|
            if file!="." && file!=".."
              files << file_info_to_hash(file)
            end
          end
        end
        files
      end

      def file_info_to_hash(file)
        info = {}
        file_stat = File.stat(File.join(@dirname, file))
        info["name"] = file
        info["size"] = file_stat.size
        info["ctime"] = file_stat.ctime.strftime("%Y-%m-%d")
        info
      end

      def delete_file(path, filename)
        filepath = File.join(path, filename)
        if File.exist?(filepath)
          return File.unlink(filepath)
        else
          return 0
        end
      end

      def file_ext(file)
        file.original_filename.split(".").last
      end

    end
  end
end
