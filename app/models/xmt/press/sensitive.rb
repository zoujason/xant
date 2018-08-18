module Xmt
  module Press
    class Sensitive
      include ModelBase
      field :title
      field :substitution
      field :enable ,type: Boolean, default: true
    end
  end
end
