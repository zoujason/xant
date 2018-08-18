module Waas
  class RememberToken
    attr_accessor :principal, :credentials, :is_remember_me

    def initialize(token)
      @principal = ''
      @credentials = token
      @is_remember_me = true
    end

  end
end

