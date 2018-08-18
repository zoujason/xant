# encoding: UTF-8
module Xmt
  module Press
    class Site < Channel
      field :host, type: String
      field :icon, type: String
      field :skin, type: String
      field :copyright , type: String
      field :hotline, type: String
      field :icp , type:String
      field :mobile, type: Boolean, default: false
      field :sponsor, type:String #主办方
      field :undertaker, type:String #承办方
      field :email, type:String
      field :identity, type:String #网站标识码
      field :netsafe_icp, type:String #网安备案号
      field :party_office, type:String #党政机关
      field :find_errors, type:String #政府找错

      mount_uploader :logo, SuploadUploader

      has_many :members, class_name: 'Xmt::Staff::Member'
      has_many :profiles, class_name: 'Xmt::Press::Profile'
      has_many :notifications, class_name: 'Xmt::Sms::Notification'
      has_many :comments, class_name: 'Xmt::Press::Comment'
      has_many :polls, class_name: 'Xmt::Faq::Poll'
      has_many :ads, class_name: 'Xmt::Ad::Ad'
      validates_uniqueness_of :slug, message: '已经存在'
      #after_create :site_file


      set_callback(:save, :before) do |doc|
        self.party_office = CGI.escape(party_office)
      end

      set_callback(:save, :after) do |doc|
        #SiteMgr.instance.load()
      end

      set_callback(:destroy, :after) do |doc|
        #SiteMgr.instance.load()
      end

      set_callback(:update, :after) do |doc|
        #SiteMgr.instance.load()
      end

      def theme
        skin || slug
      end



      # def site_traversal(&block)
      #   channels.each do |c|
      #     c.channel_traversal(&block)
      #   end
      # end

      def site_file
        views = "app/sites/#{slug}/views/#{theme}"
        assets_images = "app/sites/#{slug}/assets/images"
        assets_javascripts = "app/sites/#{slug}/assets/javascripts"
        assets_stylesheets = "app/sites/#{slug}/assets/stylesheets"
        FileUtils.mkdir_p(views) unless File.exists?(views)
        FileUtils.mkdir_p(assets_images) unless File.exists?(assets_images)
        FileUtils.mkdir_p(assets_javascripts) unless File.exists?(assets_javascripts)
        FileUtils.mkdir_p(assets_stylesheets) unless File.exists?(assets_stylesheets)
      end
    end

  end
end
