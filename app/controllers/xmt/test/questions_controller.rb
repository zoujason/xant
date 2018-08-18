module Xmt
  module Test
    class QuestionsController < AdminController
      before_action :set_xmt_test_question, only: [:show, :edit, :update, :destroy]

      # GET /test/questions
      # GET /test/questions.json
      def index
        opt = {}
        opt[:content] = /.*#{params[:key]}.*/ unless params[:key].blank?
        @questions = Xmt::Test::Question.where(opt).order(id: :desc).page(params[:page]).per(10)
      end

      # GET /test/questions/1
      # GET /test/questions/1.json
      def show
      end

      # GET /test/questions/new
      def new
        @question = Xmt::Test::Question.new
      end

      # GET /test/questions/1/edit
      def edit
      end

      # POST /test/questions
      # POST /test/questions.json
      def create
        @question = Xmt::Test::Question.generate(question_params)
        respond_to do |format|
          if @question.save
            # params[:answer].values.each do |answer|
            #   @question.answers.create(answer)
            # end
            format.html { redirect_to xmt_test_questions_url, notice: '添加成功.' }
            format.json { render :show, status: :created, location: @question }
          else
            format.html { render :new }
            format.json { render json: @question.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /test/questions/1
      # PATCH/PUT /test/questions/1.json
      def update
        respond_to do |format|
          @question.answers.delete_all()
          question_params.delete(:type)
          if @question.update(question_params)
            format.html { redirect_to xmt_test_questions_url, notice: '编辑成功.' }
            format.json { render :show, status: :ok, location: @question }
          else
            format.html { render :edit }
            format.json { render json: @question.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /test/questions/1
      # DELETE /test/questions/1.json
      def destroy
        @question.destroy
        respond_to do |format|
          format.html { redirect_to xmt_test_questions_url, notice: '删除成功.' }
          format.json { head :no_content }
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_xmt_test_question
          @question = Xmt::Test::Question.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def question_params
          params.require(:xmt_test_question).permit!
        end

    end
  end
end

