module Xmt
  module Asset
    class Style
      include ActiveModel::Model
      attr_accessor :name, :full_path, :depth, :type, :id, :file_con, :parent_id, :slug,:title
      validates_presence_of :name, :file_con,:title

      class << self
        def all(slug)
          @temps = []
          @depth = 1
          load(Rails.root.join('app', 'sites', slug, 'assets'), slug)
          @temps
        end

        def load(path, slug)

          FileUtils.mkdir_p(path) unless File.exists?(path)
          Dir.foreach(path) do |entry|
            next if (entry == '..' || entry == '.')
            full_path = File.join(path, entry)
            if File.directory?(full_path)
              file_con = ""
              @temps << new(name: entry, full_path: full_path, depth: @depth, type: :dir, id: @temps.size + 1, parent_id: @temps.size + 1, slug: slug, file_con: file_con)
              @depth +=1
              load(full_path, slug)
              @depth -=1
            else
              file_con = File.read(full_path)
              @temps << new(name: entry, full_path: full_path, depth: @depth, type: :file, id: @temps.size + 1, slug: slug, file_con: file_con, parent_id: @temps.size + 1)
            end
          end
        end

        def layouts

        end

        def templates

        end
      end

      def persisted?
        self.id
      end

      def parent
        Xmt::Asset::Style.all(slug).detect {|t| t.id.to_s == parent_id}
      end


      def delete
        File.unlink(full_path)
      end

      def sive
        names = name.split(".")
        unless valid?
          return false
        else
          if File.directory?(parent.full_path)
            if names[1] == 'css'
              newfile = parent.full_path << "/#{names[0]}.css"
            elsif names[1] == 'scss'
              newfile = parent.full_path << "/#{names[0]}.scss"
            elsif names.size == 1
              newfile = parent.full_path << "/#{name}.scss"
            end
          else
            newfile = parent.full_path
          end
          file_con.gsub!(/\r\n?/, "\n")
          line1 = file_con.to_s.split("\n")[0].to_s
          regex_title = '/* title : ' << title  << ' */'
          File.new(newfile, File::CREAT|File::TRUNC|File::RDWR, 0644)
          File.open(newfile, "w") {|fw| fw.write("#{file_con.gsub(line1, regex_title)}")}
        end
      end
    end
  end
end