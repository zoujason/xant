module Xmt
  module Test
    class PapersController < AdminController
      before_action :set_paper, only: [:show, :destroy]


      def index
        @papers = Xmt::Test::Paper.where(datatype: :app)

      end

      def show
        @paper = Xmt::Test::Paper.find(params[:id])
        respond_to do |format|
          format.html {}
          format.json {render json: @paper}
        end
      end

      def new
        @exam = Xmt::Test::Exam.find(params[:exam])
        @questions = @exam.question_library.limit(5)
        @paper = Xmt::Test::Paper.new
      end

      def create
        @exam = Xmt::Test::Exam.find(params[:xmt_test_paper][:exam_id])
        params[:xmt_test_paper][:questions].each do |question|
          if question['id'].blank?
            question.delete("id")
            @exam.create_a_question(question)
          else
            @exam.add_a_question(question['id'])
          end
        end
        respond_to do |format|
          if @exam.valid?
            format.html {redirect_to xmt_test_paper_url(@exam), notice: '创建成功.'}
            format.json {}
          else
            format.html {render :new}
            format.json {render json: @paper.errors, status: :unprocessable_entity}
          end
        end
      end

      def destroy
        @paper = Xmt::Test::Paper.find(params[:id])
        @paper.destroy
        respond_to do |format|
          format.html {redirect_to xmt_test_exams_path, notice: '删除成功.'}
          format.json {head :no_content}
        end
      end

      def ajax_next
        @exam = Xmt::Test::Exam.find(params[:select_exam])
        per = 5
        options = {
            category_id: params[:select_question_category],
            _type: params[:question_question_type],
        }.delete_if {|k, v| v.blank?}
        offset = params[:select_question_page].to_i*per
        if offset > @exam.question_library.count()
          offset = 0
        end
        questions = @exam.question_library.where(options).skip(offset).limit(per)
        result = []
        questions.map {
            |question| result << {id: question.id, content: question.content, score: question.score, answers: question.answers, typ: question._type, page: questions.count()/per}
        }
        render json: result
      end

      private

      def set_paper
        @paper = Xmt::Test::Paper.find(params[:id])
      end


    end
  end
end
