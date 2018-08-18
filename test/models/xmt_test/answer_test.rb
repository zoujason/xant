require 'test_helper'

class XmtTest::AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "score nil" do
    answer = Xmt::Test::Answer.new({title:'123',score:nil})
    assert answer.valid?
    assert_equal 0, answer.score
  end
end
