module Xmt
  module Test
    class SessionController < HomeController

      def new
      end

      def create
        user = Xmt::Staff::User.where(username: params[:session][:username]).first
        if user && user.authenticate(params[:session][:password])
          log_in user
          redirect_back_or xmt_test_root_url
        else
          flash[:danger] = "用户名或密码错误"
          render 'new'
        end
      end

      def destroy
        log_out if logged_in?
        redirect_to xmt_test_root_url
      end
    end
  end
end

