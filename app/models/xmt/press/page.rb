module Xmt
  module Press
    class Page
      include ModelBase
      include Mongoid::Tree
      include XMTHelper::PageAttr
      include StatHelper::PageStat

      field :title ,type:String , default: ''
      field :subtitle ,type:String , default: ''
      field :cont, type: String, default: ''
      field :slug, type: String, default: ''
      field :tpl, type: String, default: ''
      field :content_tpl, type: String, default: ''
      field :seo_title, type: String, default: ''
      field :seo_keywords, type: String, default: ''
      field :seo_description, type: String, default: ''
      field :linkpage, type: String, default: ''
      field :rcmd_level, type: Integer, default: 0
      field :headline_level, type: Integer, default: 0
      field :comment_options, type: Symbol, default: :open
      field :status, type: Symbol, default: :published
      field :comment_count, type: Integer, default: 0
      field :hits, type: Integer, default: 0
      field :track_backs, type: Integer, default: 0
      field :caching_data,type: String, default: ''
      field :caching_enabled, type: Boolean, default: false
      field :caching_data_m,type: String, default: ''
      field :caching_enabled_m, type: Boolean, default: false
      field :author , type: String, default: ''
      field :source,type: String, default: ''
      field :published_at , type:DateTime, default: ->{Time.now}


      mount_uploader :avatar, SuploadUploader
      belongs_to :board, class_name: 'Xmt::Press::Board', foreign_key: :parent_id, inverse_of: :pages, required:false
      has_and_belongs_to_many :tags, inverse_of: nil
      has_many :comments, class_name: 'Xmt::Press::Comment',  dependent: :delete
      embeds_many :pictures, class_name: 'Picture', inverse_of: :page
      embeds_one :cust_attr, class_name: 'Xmt::Press::CustAttr', inverse_of: :page
      has_many :attachments, as: :owner, class_name: 'Kindeditor::Asset'
      belongs_to :page_type, class_name: 'Xmt::Press::PageType', required:false
      belongs_to :dept, class_name: 'Xmt::Staff::Dept', foreign_key: :dept_id, inverse_of: :pages, required:false


      default_scope ->{where(actived: true)}
      index({ seq: -1 , published_at:-1})
      scope :publish, -> {where(status: 'published').order(seq: :desc, published_at: :desc)}
      scope :drafts, -> {where(status: 'draft').order(seq: :desc, published_at: :desc)}
      scope :pendings, -> {where(status: 'pending').order(seq: :desc, published_at: :desc)}

      set_callback(:save, :before) do |doc|
        doc.caching_enabled = false
      end


      def url
        self.linkpage.blank? ? "/pages/#{self.id}" : self.linkpage
      end

      def hit(num = nil)
        num ||= 1
        self.update_attributes(hits: self.hits + num)
      end

      def page_view(options={})
        self.page_views.create(options)
      end

      def site
        @site ||= SiteMgr.instance.find_by_parents(self.parent_ids)
        @site ||= self if self.is_a? Site
        @site
      end

      def cont_tpl
        cont_tpl = self.tpl
        cont_tpl = self.parent.try(:content_tpl) if cont_tpl.blank? && self.parent
        cont_tpl || 'tpl_content'
      end

      def cont_layout
        cont_layout = self.parent.try(:layout)
        cont_layout = self.site.layout if cont_layout.blank?
        cont_layout = self.try(:layout) unless self.try(:layout).blank?
        cont_layout || 'theme'
      end

      def update_caching_status
        self.ancestors.update_all(caching_enabled: false, caching_enabled_m: false)
        pre = self.previous
        pre && pre.update(caching_enabled: false, caching_enabled_m: false)
        nex = self.next
        nex && nex.update(caching_enabled: false, caching_enabled_m: false)
      end

      def update_caching(data)
        self.update_attributes({caching_data: data, caching_enabled: true})
        self.update_caching_status
      end

      def update_caching_m(data)
        self.update_attributes({caching_data_m: data, caching_enabled_m: true})
        self.update_caching_status
      end

      def has_caching?
        self.caching_enabled  && !self.caching_data.blank?
      end

      def has_caching_m?
        self.caching_enabled_m  && !self.caching_data_m.blank?
      end


      def previous
        self.class.publish.where(parent_id: self.parent_id, :published_at.gt =>  self.published_at).first
      end

      def next
        self.class.publish.where(parent_id: self.parent_id, :published_at.lt =>  self.published_at).first
      end


      #--------template helper method -----------
      def name
        subtitle.blank? ? title : subtitle
      end

      def sensitive(sensitives,cont)
        str = cont || ''
        if sensitives.count > 0
          sensitives.each do |sensitive|
            str && str.gsub!(/#{sensitive.title}/, sensitive.substitution)
          end
        end
        str
      end

      def clone_to_hash()
        self.attributes.dup
      end

    end

  end
end
