#encoding:UTF-8
module Xmt
  module Test
    class Exam < Paper
      Cache_paper_num = 10

      field :start_at, type: DateTime
      field :end_at, type: DateTime

      def get_paper
        all_papers[rand(all_papers.size)]
      end

      def start?
        flag = true
        unless start_at.blank?
          if (Time.now < start_at)
            flag = false
          end
        end
        flag
      end

      def expired?
        flag = false
        unless end_at.blank?
          if (Time.now > end_at)
            flag = true
          end
        end
        flag

      end

      set_callback(:destroy, :before) do |document|
        document.destroy_children if document.children.count>0
      end

    end

  end
end
