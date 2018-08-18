module Xmt
  module Rbac
    class Group
      include ModelBase
      include Mongoid::Tree
      field :name
      field :sign
      has_and_belongs_to_many :roles, class_name:'Xmt::Rbac::Role',validate: false
    end
  end
end