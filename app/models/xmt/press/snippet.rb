module Xmt
  module Press
    class Snippet
      include ModelBase
      field :title ,type:String
      field :cont  ,type:String
      field :sign  ,type:String
      field :tag_type  ,type:String
      #validates_uniqueness_of :sign
    end

  end
end
