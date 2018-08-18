module Waas
  class FormToken
    attr_accessor :principal, :credentials, :is_remember_me

    def initialize(username, password, is_remember_me = false)
      @principal = username
      @credentials = password
      @is_remember_me = is_remember_me
    end

  end
end
