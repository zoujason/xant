module Xmt
  module Nav
    class MenuItem
      include ModelBase
      include Mongoid::Tree
      include Mongoid::Tree::Traversal

      field :name, type: String
      field :path, type: String
      field :icon, type: String

      has_many :permissions, as: :acopermitable, class_name: 'Xmt::Rbac::Permission'

      set_callback(:save, :after) do |doc|
        AdminMenuMgr.instance.load()
      end

      set_callback(:destroy, :after) do |doc|
        AdminMenuMgr.instance.load()
      end

      set_callback(:update, :after) do |doc|
        AdminMenuMgr.instance.load()
      end

    end
  end
end
