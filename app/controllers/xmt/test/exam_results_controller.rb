module Xmt
  module Test
    class ExamResultsController < HomeController
      before_action :logged_in_user
      # before_action :exam_result_build, only: :create

      def show
        @exam_result = Xmt::Test::ExamResult.find(params[:id])
        @total_marks = @exam_result.question_scores.sum(:marks)
      end

      def new
        @exam = Xmt::Test::Exam.find(params[:exam])
        @paper = @exam.get_paper

      end

      def create
        # render plain: params[:paper].inspect
        @paper = Xmt::Test::Paper.find(id: params[:paper_id])
        @exam_result = @paper.pc_create_results(params[:user_id], params[:results])
        respond_to do |format|
          if @exam_result
            format.html {redirect_to @exam_result}
          else
            format.html {render new_xmt_test_test_url(exam: @paper.exam_id, cat_id: @paper.category_id), notice: '提交失败,请重新提交'}
          end
        end
      end

      private

      def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "请登录"
          redirect_to xmt_test_login_path
        end
      end

    end
  end
end
