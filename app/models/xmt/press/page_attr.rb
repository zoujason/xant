module Xmt
  module Press
    class PageAttr
      include ModelBase
      field :title ,type:String
      field :sign ,type:String
      field :attr_type ,type:String
      field :def_datas ,type:String
      field :attr_relation ,type:String
      field :attr_condition ,type:String
      field :relation_data ,type:String

      embedded_in :page_type, class_name: 'Xmt::Press::PageType'
    end
  end
end