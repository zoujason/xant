module Xmt
  module Test
    class ExamResult
      include ModelBase

      belongs_to :user, class_name: 'Xmt::Staff::User', inverse_of: :exam_results
      belongs_to :paper, class_name: 'Xmt::Test::Paper'
      embeds_many :question_scores, class_name: 'Xmt::Test::QuestionScore'

      def create_question_scores(result)
        question = Xmt::Test::Question.find(result['question'])
        result_score = 0
        if question.answers_righted?(result['answer_ids'])
          result_score = paper.question_score(question)
        end
        question_scores.create({question_id: result['question'], answer_ids: result['answer_ids'], marks: result_score})
      end
    end
  end
end
