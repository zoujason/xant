module Xmt
  module Staff
    class Dept
      include ModelBase
      include Mongoid::Tree
      include Mongoid::Tree::Traversal
      field :title , type: String, default: ''
      field :sign , type: Symbol, default: :xzf
      field :seq,type: Integer, default: 0
      field :navigable, type: Boolean, default: true
      field :published_at , type:DateTime, default: ->{Time.now}
      has_many :pages,class_name: 'Xmt::Press::Page', dependent: :delete
      has_many :users,class_name: 'Xmt::Staff::User', dependent: :delete



      default_scope ->{where(actived: true).order(seq: -1,published_at:1)}
      index({ seq: -1 ,published_at:1})

      def ancestors_and_self_name_format
        names = []
        self.ancestors_and_self.each do |dept|
          names << dept.title
        end
        names.join('>>')
      end

    end
  end
end