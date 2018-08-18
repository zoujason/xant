module Waas
  class AuthcRealm
    def initialize(authc_for = Xmt::Staff::User)
      @authc_for = authc_for
    end

    def authenticate(token)
      if token.is_a?(Waas::RememberToken)
        user = Xmt::Staff::User.find_by_token(token.credentials)
        info = AuthcInfo.new(user.username, user.token == token.credentials)
      else
        user = Xmt::Staff::User.find_by_principal(token.principal)
        user.token = SecureRandom.urlsafe_base64
        user.save unless user.new_record?
        info = AuthcInfo.new(token.principal, user.authenticate(token.credentials))
      end

      info.remember_token = user.token
      info.username = user.username
      info.user_id = user.id
      info
    end

  end
end
