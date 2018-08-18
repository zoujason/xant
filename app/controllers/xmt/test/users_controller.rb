module Xmt
  module Test
    class UsersController < HomeController
      def show

      end

      def new
        @user = Xmt::Staff::User.new
      end

      def create
        @user = Xmt::Staff::User.new(user_params)
        respond_to do |format|
          if @user.save
            format.html { redirect_to xmt_test_root_url, notice: '注册成功' }
          else
            format.html { render :new }
          end
        end

      end

      private
        def user_params
          params.require(:user).permit!
        end

    end
  end
end
