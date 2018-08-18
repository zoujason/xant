module Xmt
  module Test
    class QuestionScore
      include Mongoid::Document

      field :answer_ids,type:Array
      field :marks, type: Float

      embedded_in :score, :class_name => 'Xmt::Test::Score'
      belongs_to :question, :class_name => 'Xmt::Test::Question'


    end
  end
end
