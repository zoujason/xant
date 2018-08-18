require 'form_token'
require 'authc_realm'
require 'authc_info'
require 'authc'
require 'subject'
require 'security'
require 'authc_filter'
require 'session'
require 'authz_info'
require 'authz_realm'
require 'authz'
require 'remember_token'

module Waas
  class << self
    attr_accessor :login_url, :home_url, :authc_for

    def setup
      yield(self) if block_given?
    end

  end

end



