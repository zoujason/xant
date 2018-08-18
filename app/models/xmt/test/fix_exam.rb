module Xmt
  module Test
    class FixExam < Exam

      def all_papers
        arr = []
        if questions.count>0
          arr << self
        end
        arr
      end


    end
  end
end
