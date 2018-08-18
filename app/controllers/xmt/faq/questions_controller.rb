module Xmt
  module Faq
    class QuestionsController < AdminController

      before_action :set_question, only: [:show, :edit, :update, :destroy]

      # GET /questions
      # GET /questions.json
      def index
        @questions = Xmt::Faq::Question.all
      end

      # GET /questions/1
      # GET /questions/1.json
      def show
      end

      # GET /questions/new
      def new
        @question = Xmt::Faq::Question.new
      end

      # GET /questions/1/edit
      def edit
      end

      # POST /questions
      # POST /questions.json
      def create
        @question = Xmt::Faq::Question.new(question_params)

        respond_to do |format|
          if @question.save
            format.html {redirect_to xmt_faq_questions_url, notice: '问题创建成功.'}
            format.json {render :show, status: :created, location: @question}
          else
            format.html {render :new}
            format.json {render json: @question.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /questions/1
      # PATCH/PUT /questions/1.json
      def update
        respond_to do |format|
          if @question.update(question_params)
            format.html {redirect_to xmt_faq_questions_url, notice: '问题修改成功.'}
            format.json {render :show, status: :ok, location: @question}
          else
            format.html {render :edit}
            format.json {render json: @question.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /questions/1
      # DELETE /questions/1.json
      def destroy
        @question.destroy
        respond_to do |format|
          format.html {redirect_to xmt_faq_questions_url, notice: '问题删除成功.'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_question
        @question = Xmt::Faq::Question.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def question_params
        params.require(:xmt_faq_question).permit!
      end
    end
  end
end
