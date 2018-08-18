module Waas
  class AuthzInfo
    attr_accessor :roles

    def initialize(roles)
      @roles = roles || []
    end

  end
end
