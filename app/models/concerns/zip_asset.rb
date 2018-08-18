require 'zip'
class ZipUtil
# 解压文件方法
# zif_file_path 压缩文件的访问路径
# extract_directory 解压文件的保存目录
  def self.extract_from_zip_file(zif_file_path,site)
    unless File.exist?(zif_file_path)
      puts "文件:#{zif_file_path}不存在."
      return 0
    end
    Zip::File.open(zif_file_path) do |zif_file|
      zif_file.each do |entry|
        # entyr是Zip::ZipEntry的对象
        # 利用File.join构建文件存放的路径,路径为存放目录加上压缩文件的相对路径
        #判断已有文件是否存在  如果有 删除
        #判断目录中是资源 还是模板
        if entry::name.to_s.include?("views")

          extract_directory_moban = "#{Rails.root}/app/sites/#{site.layout}"
          Dir.mkdir(extract_directory_moban) unless File.exist?(extract_directory_moban)
          if entry::ftype.to_s == 'file'
            if File::exists?(File.join(extract_directory_moban,entry::name))
              File.delete( File.join(extract_directory_moban,entry::name) )
            end
          end
          entry.extract(File.join(extract_directory_moban,entry::name))
        else
          extract_directory_ziyuan = "#{Rails.root}/public"
          Dir.mkdir(extract_directory_ziyuan) unless File.exist?(extract_directory_ziyuan)
          if entry::ftype.to_s == 'file'
            if File::exists?(File.join(extract_directory_ziyuan,entry::name))
              File.delete( File.join(extract_directory_ziyuan,entry::name) )
            end
          end
          entry.extract(File.join(extract_directory_ziyuan,entry::name))
        end

      end
    end
  end

  # 压缩文件方法
  # zip_file_name 压缩文件绝对路径，含文件名
  # file_path 要解压的目录或文件
  def self.add_to_zip_file(zip_file_name,file_path)
    # start_path 表示
    def self.add_file(start_path,file_path,zip)
      # 如果文件是一个目录则递归调用此方法
      if File.directory?(file_path)
        # 建立目录
        # 如果省略下一行代码，则当目录为空时，此目录将不会显示在压缩文件中
        zip.mkdir(file_path)
        puts "建立目录#{file_path}"
        Dir.foreach(file_path) do |filename|
          #递归调用add_file方法
          add_file("#{start_path}/#{filename}","#{file_path}/#{filename}",zip) unless filename=="." or filename==".."
        end
      else
        # 给压缩文件中添加文件
        # start_path 被添加文件在压缩文件中显示的路径
        # file_path 被添加文件的源路径
        zip.add(start_path,file_path)
        puts "添加文件#{file_path}"
      end
    end

    # 如果文件已存在，则删除此文件
    if File.exist?(zip_file_name)
      puts "文件已存在，将会删除此文件并重新建立。"
      File.delete(zip_file_name)
    end

    # 取得要压缩的目录父路径，以及要压缩的目录名
    chdir,tardir = File.split(file_path)
    # 切换到要压缩的目录
    Dir.chdir(chdir) do
      # 创建压缩文件
      puts "开始创建压缩文件"
      Zip::File.open(zip_file_name,Zip::File::CREATE) do |zipfile|
        puts "文件创建成功，开始添加文件..."
        # 调用add_file方法，添加文件到压缩文件
        puts "已添加文件列表如下:"
        add_file(tardir,tardir,zipfile)
      end
    end
  end

end



if __FILE__ == $0
  # path = "D:/assets.zip"
  ZipUtil.extract_from_zip_file("C:/Users/zxl/Desktop/assets.zip","C:/Users/zxl/Desktop/20106/")
 # ZipUtil.add_to_zip_file("C:/Users/zxl/Desktop/test.zip","C:/Users/zxl/Desktop/20106/")
  #  ZipAsset.unzip(path)
end