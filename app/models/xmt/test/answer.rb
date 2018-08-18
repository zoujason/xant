module Xmt
  module Test
    class Answer
      include Mongoid::Document

      field :title, type: String
      field :righted, type: Boolean, default: false
      field :score, type: Float, default: 0.0

      embedded_in :question, :class_name => 'Xmt::Test::Question'

      validates :title, presence: true
      validates :score, presence: true,numericality: true

      before_validation :format_score

      private
        def format_score
          if self.score.nil?
            self.score = 0;
          end
        end
    end
  end
end
