#encoding:UTF-8
module Xmt
  module Test
    class Question
      include ModelBase

      field :content, type: String
      # field :typ, type: Integer #1单选 2多选 3判断
      field :score, type: Float
      field :difficulty, type: Integer #难度等级
      field :category_parent_ids, type: Array

      belongs_to :category, class_name: 'Xmt::Test::Category', required: false
      embeds_many :answers, class_name: 'Xmt::Test::Answer'

      validates :content, presence: true
      validates :score, presence: true, numericality: true

      before_create :set_category_parent_ids
      before_update :set_category_parent_ids


      def answers_righted?(answer_arr)
        righted_arr = answers_righted_ids
        (answer_arr-righted_arr).empty? && (answer_arr.length == righted_arr.length)
      end

      def answers_righted_ids
        answers.where(righted: true).map {|answer| answer.id.to_s}
      end

      def self.generate(attrs)
        case attrs.delete('type')
          when 'Xmt::Test::SingleChoice'
            Xmt::Test::SingleChoice.new(attrs)
          when 'Xmt::Test::MultipleChoice'
            Xmt::Test::MultipleChoice.new(attrs)
          when 'Xmt::Test::BinaryChoice'
            Xmt::Test::BinaryChoice.new(attrs)
          else
            Xmt::Test::Question.new
        end
      end

      def self.find_question_by_category(typ, category_id)
        case typ
          when 'Xmt::Test::SingleChoice'
            questions = Xmt::Test::SingleChoice.where(category_id: category_id)
          when 'Xmt::Test::MultipleChoice'
            questions = Xmt::Test::MultipleChoice.where(category_id: category_id)
          when 'Xmt::Test::BinaryChoice'
            questions = Xmt::Test::BinaryChoice.where(category_id: category_id)
          else
            questions = nil
        end
        questions
      end

      private

      def set_category_parent_ids
        self.category_parent_ids = self.category.ancestors_and_self.map(&:id)
      end

    end
  end
end
