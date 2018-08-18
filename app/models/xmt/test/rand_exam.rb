module Xmt
  module Test
    class RandExam < Exam

      def generate_cache_papers(default = nil)
        default ||= Exam::Cache_paper_num
        default.to_i.times do
          rand_a_paper
        end
      end

      def rand_a_paper
        Xmt::Test::Paper.create({datatype: :sys, parent_id: self,site_id:self.site_id}) do |paper|
          type_rules.each do |rule|
            paper.rand_questions(rule['question_size'].to_i, rule['question_type'])
          end
        end
      end

      def cache_paper_reset
        destroy_children if children.count>0
        generate_cache_papers
      end

      def all_papers
        if children.size < Exam::Cache_paper_num
          rand_a_paper
        end
        children
      end



    end
  end
end
