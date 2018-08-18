module Xmt
  module Test
    class Paper
      include ModelBase
      include Mongoid::Tree

      field :title, type: String
      belongs_to :category, class_name: 'Xmt::Test::Category', required: false
      embeds_many :type_rules, class_name: 'Xmt::Test::TypeRule'
      has_and_belongs_to_many :questions, class_name: 'Xmt::Test::Question', inverse_of: nil
      has_many :exam_results, class_name: 'Xmt::Test::ExamResult'
      belongs_to :site, class_name: 'Xmt::Press::Site', required: false

      def rand_questions(num, type)
        question = Xmt::Test::Question.find_question_by_category(type, parent.category.id)
        len = question.size
        ran_arr = (1..len-1).to_a.sample(num)
        num.times do |i|
          questions << question.skip(ran_arr[i]).limit(1).first
        end
      end

      def create_a_question(question)
        question = Xmt::Test::Question.generate(question.permit!)
        unless question.save
          self.errors.push '第'+question.seq+'题创建出错'
        end
        questions << question
      end

      def add_a_question(question_id)
        questions << Xmt::Test::Question.where(id: question_id)
      end

      def question_library
        Xmt::Test::Question.where(category_parent_ids: category_id)
      end


      def pc_create_results(user_id, results)
        exam_result = exam_results.build({user_id: user_id})
        results.values.each do |result|
          exam_result.save
          exam_result.create_question_scores(result)
        end
        exam_result
      end

      def question_score(question)
        score = 0
        unless (rule = rules.where(question_type: question.class.to_s).first).nil?
          score = rule.score
        end
      end

      def rules
        rules = root? ? self.type_rules : parent.type_rules
      end

      def person_latest_result(user_id)
        exam_results.where(user_id: user_id).order(created_at: :desc).first.question_scores.sum(:marks)
      end

      def person_highest_result(user_id)
        score = []
        exam_results.where(user_id: user_id).each do |exam_r|
          score << exam_r.question_scores.sum(:marks)
        end
        score.max
      end

    end
  end
end