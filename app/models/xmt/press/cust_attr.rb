module Xmt
  module Press
    class CustAttr
      include Mongoid::Document
      include Mongoid::Attributes::Dynamic
      embedded_in :page, inverse_of: :cust_attr

    end
  end
end