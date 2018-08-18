module Waas
  class Authc

    def initialize
      @realm = AuthcRealm.new(Xmt::Staff::Manager)
    end

    def approve(token)
      return @realm.authenticate(token)
    end

  end
end
