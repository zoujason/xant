module Xmt
  module Test
    class FixExamsController < AdminController
      before_action :set_xmt_test_fix_exam, only: [:show, :edit, :update, :destroy]
      before_action :set_site


      # GET /test/fix_exams/new
      def new
        @fix_exam = Xmt::Test::FixExam.new
      end

      # GET /test/fix_exams/1/edit
      def edit
      end

      # POST /test/fix_exams
      # POST /test/fix_exams.json
      def create
        @fix_exam = Xmt::Test::FixExam.new(fix_exam_params)
        respond_to do |format|
          if @fix_exam.save
            format.html {redirect_to new_xmt_test_paper_url(exam: @fix_exam.id), notice: '创建成功.'}
            format.json {render :show, status: :created, location: @fix_exam}
          else
            format.html {render :new}
            format.json {render json: @fix_exam.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /test/fix_exams/1
      # PATCH/PUT /test/fix_exams/1.json
      def update
        respond_to do |format|
          if @fix_exam.update(fix_exam_params)
            format.html {redirect_to xmt_test_exams_path, notice: '编辑成功.'}
            format.json {render :show, status: :ok, location: @fix_exam}
          else
            format.html {render :edit}
            format.json {render json: @fix_exam.errors, status: :unprocessable_entity}
          end
        end
      end


      private
      # Use callbacks to share common setup or constraints between actions.
      def set_xmt_test_fix_exam
        @fix_exam = Xmt::Test::FixExam.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def fix_exam_params
        params.require(:xmt_test_fix_exam).permit!
      end

      def set_site
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])

      end
    end
  end
end
