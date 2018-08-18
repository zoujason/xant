module Xmt
  module Faq
    class AnswersController < AdminController
      before_action :set_answer, only: [:show, :edit, :update, :destroy]

      # GET /answers
      # GET /answers.json
      def index
        @answers = Xmt::Faq::Answer.all.page(params[:page])
      end

      # GET /answers/1
      # GET /answers/1.json
      def show
      end

      # GET /answers/new
      def new
        @answer = Xmt::Faq::Answer.new
      end

      # GET /answers/1/edit
      def edit
      end

      # POST /answers
      # POST /answers.json
      def create
        @answer = Xmt::Faq::Answer.new(answer_params)

        respond_to do |format|
          if @answer.save
            format.html {redirect_to xmt_faq_answers_url, notice: '问题创建成功.'}
            format.json {render :show, status: :created, location: @answer}
          else
            format.html {render :new}
            format.json {render json: @answer.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /answers/1
      # PATCH/PUT /answers/1.json
      def update
        respond_to do |format|
          if @answer.update(answer_params)
            format.html {redirect_to xmt_faq_answers_url, notice: '问题修改成功.'}
            format.json {render :show, status: :ok, location: @answer}
          else
            format.html {render :edit}
            format.json {render json: @answer.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /answers/1
      # DELETE /answers/1.json
      def destroy
        @answer.destroy
        respond_to do |format|
          format.html {redirect_to xmt_faq_answers_url, notice: '问题删除成功.'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_answer
        @answer = Xmt::Faq::Answer.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def answer_params
        # params.fetch(:answer, {})
        params.require(:xmt_faq_answer).permit!

      end
    end
  end
end
