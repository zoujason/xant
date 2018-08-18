class Addon
  include ActiveModel::Model
  attr_accessor :name, :path, :sign, :version, :date, :isinstall

  def setup
    item = Xmt::Nav::MenuItem.find_by(name: '扩展管理')
    item.children.create({name: name, path: path})
  end

  def drop
    Xmt::Nav::MenuItem.where(name: name).find_one_and_delete
  end

  def save(args)
    hash = {'name' => "#{name}" , 'path' => "#{path}", 'sign' => "#{sign}", 'version' => "#{version}", 'date' => "#{date}",'isinstall' => "#{args[:isinstall]}"}
    File.open("#{Rails.root}/vendor/addons/#{name}/index.yml", 'w') { |f|
      YAML.dump(hash, f)
    }
  end

  class << self
    def all
      @apps = []
      map_dir
      @apps
    end

    def map_dir
      Dir.glob("#{Rails.root}/vendor/addons/*/index.yml") do |file|
        @File = YAML::load(File.read(file))
        @apps << new(name: @File['name'], path: @File['path'], sign: @File['sign'], version: @File['version'], date: @File['date'], isinstall: @File['isinstall'])
      end
    end

  end


end