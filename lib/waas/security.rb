module Waas
  class Security
    class << self

      def authc
        @authc ||= Authc.new
      end

      def authz
        @authz ||= Authz.new
      end

      def session
        @session ||= Session.new
      end

      def subject
        Thread.current[:waas_session_subject]
      end

      def subject=(obj)
        Thread.current[:waas_session_subject] = obj
      end

      def init(env)
        if env.session[:subject]
          self.subject = env.session[:subject]
        else
          self.subject = Subject.new()
        end
        self.subject.session = env.session
      end

    end

  end
end
