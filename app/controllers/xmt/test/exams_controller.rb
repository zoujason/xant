module Xmt
  module Test
    class ExamsController < AdminController
      before_action :set_xmt_test_exam, only: [:show, :edit, :update, :destroy]
      before_action :set_site


      def index
        opt = {}
        opt[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?
        @exam = Xmt::Test::Exam.where(site_id: @site.id).where(opt).order(id: :desc).page(params[:page]).per(10)
      end

      def show
      end

      def new
        @exam = Xmt::Test::Exam.new
      end

      def edit
      end

      def create
        @exam = Xmt::Test::Exam.generate(exam_params)
        respond_to do |format|
          if @exam.save
            format.html {redirect_to xmt_test_exams_url, notice: '添加成功.'}
            format.json {render :show, status: :created, location: @exam}
          else
            format.html {render :new}
            format.json {render json: @exam.errors, status: :unprocessable_entity}
          end
        end
      end

      def update
        respond_to do |format|
          if @exam.update (exam_params)
            format.html {redirect_to xmt_test_exams_url, notice: '编辑成功.'}
            format.json {render :show, status: :ok, location: @exam}
          else
            format.html {render :edit}
            format.json {render json: @exam.errors, status: :unprocessable_entity}
          end
        end
      end

      def destroy
        @exam.destroy
        respond_to do |format|
          format.html {redirect_to xmt_test_exams_url, notice: '删除成功.'}
          format.json {head :no_content}
        end
      end


      private
      def set_xmt_test_exam
        @exam = Xmt::Test::Exam.find(params[:id])
      end

      def exam_params
        params.require(:xmt_test_exam).permit!
      end

      def set_site
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])

      end

    end
  end
end