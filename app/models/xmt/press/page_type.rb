module Xmt
  module Press
    class PageType
      include ModelBase
      field :title,type: String,default: ''

      has_many :page, class_name: 'Xmt::Press::Page', dependent: :delete
      embeds_many :page_attrs ,class_name:'Xmt::Press::PageAttr'

    end
  end
end