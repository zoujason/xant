module Xmt
  module Faq
    class Sharedoc < Mailbox
      field :pwd, type: String #密码
      field :provide, type: Array #提供
      field :obtain, type: Array #获取
      field :purpose, type: String #用途
      field :address, type: String #地址
      field :code, type: String #邮政编码
      field :telphone, type: String #传真
      field :cardname, type: String #证件名称
      field :workname, type: String #单位名称
      field :identity, type: String #身份

      belongs_to :dept, class_name: 'Xmt::Staff::Dept', foreign_key: :dept_id, inverse_of: :pages, required: false

    end
  end
end