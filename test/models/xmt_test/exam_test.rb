require 'test_helper'

class XmtTest::ExamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    5.times do |n|
      create("single#{n}")
    end
    4.times do |n|
      create("multiple#{n}")
    end

  end

  test "random select paper" do
    exam_with_papers = create(:exam_random_with_papers)
    exam_no_paper = create(:exam_random_no_papers)
    assert exam_with_papers.papers.include?(exam_with_papers.random_paper)
    assert exam_no_paper.random_paper.nil?
  end

  test "build random paper" do
    exam_no_paper = create(:exam_random_no_papers)
    assert_difference 'XmtTest::Paper.count', 1 do
      result = exam_no_paper.build_random_paper

      assert exam_no_paper.id == result.exam.id

      result.questions.each do |question|
        assert_equal 1, question.category.id
      end

      assert_equal 4, result.questions.count
      assert_equal 2,Xmt::Test::SingleChoice.in(result.questions.map(&:id)).count()
      assert_equal 2,Xmt::Test::MultipleChoice.in(result.questions.map(&:id)).count()

    end


  end


end
