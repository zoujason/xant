module Waas
  module AuthcFilter
    def self.included(base)
      base.class_eval do
        include InstanceMethods
        before_action :authc_init
        before_action :authc_filter
        helper_method :subject
      end
    end

    module InstanceMethods
      def authc_init
        Waas::Security.init(self)
      end

      def authc_filter
        unless Waas::Security.subject.authenticated?
          unless cookies[:auth_token].blank?
            token = Waas::RememberToken.new(cookies[:auth_token])
            unless Waas::Security.subject.login(token)
              redirect_to  Waas.login_url
              return
            end
          end
          redirect_to  Waas.login_url
        end
      end

      def subject
        Waas::Security.subject
      end
    end

  end
end
