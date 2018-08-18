module Waas
  class Subject
    attr_reader :principal, :authenticated, :session_id, :host, :username, :user_id, :remember_token
    attr_accessor :session

    def initialize(opt = {})
      @url = opt[:url]
      @session_id = opt[:session_id]
      @host = opt[:host]
      @principal = opt[:principal]
      @authenticated = opt[:authenticated] || false
      #@session = Security.session
      @roles = []
      @username = ''
      @user_id = ''
    end

    def user
      @user = @user || Xmt::Staff::User.where(id: @user_id).first
    end

    def marshal_dump
      [@username, @user_id, @authenticated, @roles]
    end

    def marshal_load(array)
      @username, @user_id, @authenticated, @roles = array
    end

    def login(token)
      info = Security.authc.approve(token)
      if info.authenticated
        @principal = info.principal
        @authenticated = info.authenticated
        @username = info.username
        @user_id = info.user_id
        @remember_token = info.remember_token
        @roles = Security.authz.approve(info.principal).roles.to_a
      end
      @session[:subject] = self
      return @authenticated
    end

    def logout
      @principal = ''
      @authenticated = false
      @session[:subject] = nil
    end

    def authenticated?
      @session[:subject] && @authenticated
    end

    def has_role(sign)
      @roles.any? {|role| role.sign.to_s == sign.to_s}
    end

    def allow(aco_id, operation)
     # p aco_id
      return true if has_role(:sys_admin)
      @roles.any? {|role| Security.authz.permit(role.id, BSON::ObjectId(aco_id), operation)}
      #return false
      #Security.authz.permit(@roles.first.id, aco_id, operation)
    end
  end
end
