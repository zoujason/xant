module Xmt
  module Rbac
    class Privilege
      include Mongoid::Document

      field :operation, type: Symbol
      field :permit, type: Boolean, default: false #allow:true  deny:false

      embedded_in :permission


    end
  end
end
