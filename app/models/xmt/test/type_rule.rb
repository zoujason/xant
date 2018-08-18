module Xmt
  module Test
    class TypeRule
      include Mongoid::Document

      field :question_type
      field :question_size
      field :score, type: Float

      embedded_in :paper, class_name: 'Xmt::Test::Paper'

    end
  end
end
