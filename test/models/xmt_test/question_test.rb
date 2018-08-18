require 'test_helper'

class XmtTest::QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @single_question = create(:single)
    @multi_question = create(:multi)
  end

  test "get question righted answers ids" do
    assert_equal ["#{@single_question.answers.first.id}"], @single_question.answers_righted_ids
    assert_equal ["#{@multi_question.answers.first.id}", "#{@multi_question.answers.last.id}"], @multi_question.answers_righted_ids
  end

  test "get SingleChoice score according to answer_ids" do
    @single_question.answers.each do |answer|
      if answer.righted
        assert_equal @single_question.score, @single_question.get_radio_score(["#{answer.id}"])
      else
        assert_equal 0, @single_question.get_radio_score(["#{answer.id}"])
      end
    end
  end

  test "get MultipleChoice score according to answer_ids by type all" do
    answer_arr = @multi_question.answers.map(&:id).sample(Random.rand(1..4))
    righted_answers = @multi_question.answers_righted_ids
    30.times do
      if (answer_arr-righted_answers).empty? && (answer_arr.size==righted_answers.size)
        assert_equal @multi_question.score, @multi_question.get_mutiple_score_all(answer_arr)
      else
        assert_equal 0, @multi_question.get_mutiple_score_all(answer_arr)
      end
    end
  end

  test "get MultipleChoice score according to answer_ids by type subitem" do
    answer_arr = @multi_question.answers.map(&:id).sample(Random.rand(1..4))
    righted_answers = @multi_question.answers_righted_ids
    30.times do
      if (answer_arr-righted_answers).empty?
        assert_equal @multi_question.answers.in(id: answer_arr).sum(:score), @multi_question.get_mutiple_score_subitem(answer_arr)
      else
        assert_equal 0, @multi_question.get_mutiple_score_subitem(answer_arr)
      end
    end
  end

  test "question generate" do
    assert Xmt::Test::Question.generate({"content"=>"single", "score"=>"4", "type"=>"XmtTest::SingleChoice"}).instance_of?(Xmt::Test::SingleChoice)
    assert Xmt::Test::Question.generate({"content"=>"single", "score"=>"4", "type"=>"XmtTest::MultipleChoice"}).instance_of?(Xmt::Test::MultipleChoice)
    assert Xmt::Test::Question.generate({"content"=>"single", "score"=>"4", "type"=>"XmtTest::BinaryChoice"}).instance_of?(Xmt::Test::BinaryChoice)
    assert Xmt::Test::Question.generate({"content"=>"single", "score"=>"4", "type"=>""}).instance_of?(Xmt::Test::Question)
  end

end
