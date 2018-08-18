module Xmt
  module Test
    class RandExamsController < AdminController
      before_action :set_xmt_test_rand_exam, only: [:show, :edit, :update, :destroy]
      before_action :set_site
      # GET /test/rand_exams
      # GET /test/rand_exams.json
      def index
        @rand_exams = Xmt::Test::RandExam.all
      end

      # GET /test/rand_exams/1
      # GET /test/rand_exams/1.json
      def show

      end

      # GET /test/rand_exams/new
      def new
        @rand_exam = Xmt::Test::RandExam.new
      end

      # GET /test/rand_exams/1/edit
      def edit
      end

      # POST /test/rand_exams
      # POST /test/rand_exams.json
      def create
        @rand_exam = Xmt::Test::RandExam.new(rand_exam_params)
        respond_to do |format|
          if @rand_exam.save
             @rand_exam.generate_cache_papers
            format.html { redirect_to xmt_test_exams_path, notice: '添加成功.' }
            format.json { render :show, status: :created, location: @rand_exam }
          else
            format.html { render :new }
            format.json { render json: @rand_exam.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /test/rand_exams/1
      # PATCH/PUT /test/rand_exams/1.json
      def update
        respond_to do |format|
          if @rand_exam.update(rand_exam_params)
             @rand_exam.cache_paper_reset
            format.html { redirect_to xmt_test_exams_path, notice: '编辑成功.' }
            format.json { render :show, status: :ok, location: @rand_exam }
          else
            format.html { render :edit }
            format.json { render json: @rand_exam.errors, status: :unprocessable_entity }
          end
        end
      end



      private
        # Use callbacks to share common setup or constraints between actions.
        def set_xmt_test_rand_exam
          @rand_exam = Xmt::Test::RandExam.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def rand_exam_params
          params.require(:xmt_test_rand_exam).permit!
        end

        def set_site
          @sites = Xmt::Press::Site.all
          @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
        end
    end
  end
end
