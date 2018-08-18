module Xmt
  module Faq
    class Message
      include ModelBase
      include Mongoid::Tree

      field :title
      field :cont
      field :typ
      field :email
      field :tel
      field :checked, type: Boolean
      field :rcmded, type: Boolean
      field :reply

      belongs_to :site,class_name: 'Xmt::Press::Site',foreign_key: :site_id , required: false

    end
  end
end
