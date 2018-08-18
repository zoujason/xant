module Waas
  class AuthcInfo
    attr_reader :principals, :authenticated, :salt, :realm_name
    attr_accessor :username, :user_id, :remember_token

    def initialize(principal, authenticated)
      @principals = [principal]
      @authenticated = authenticated
      @salt = ''
      @realm_name = ''
      @username = ''
      @user_id = ''
      @remember_token = ''
    end

    def principal
      @principals.first
    end

  end
end

