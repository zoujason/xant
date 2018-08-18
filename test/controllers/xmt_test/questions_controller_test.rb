require 'test_helper'

class XmtTest::QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xmt_test_question = xmt_test_questions(:one)
  end

  test "should get index" do
    get xmt_test_questions_url
    assert_response :success
  end

  test "should get new" do
    get new_xmt_test_question_url
    assert_response :success
  end

  test "should create xmt_test_question" do
    assert_difference('XmtTest::Question.count') do
      post xmt_test_questions_url, params: { xmt_test_question: {  } }
    end

    assert_redirected_to xmt_test_question_url(XmtTest::Question.last)
  end

  test "should show xmt_test_question" do
    get xmt_test_question_url(@xmt_test_question)
    assert_response :success
  end

  test "should get edit" do
    get edit_xmt_test_question_url(@xmt_test_question)
    assert_response :success
  end

  test "should update xmt_test_question" do
    patch xmt_test_question_url(@xmt_test_question), params: { xmt_test_question: {  } }
    assert_redirected_to xmt_test_question_url(@xmt_test_question)
  end

  test "should destroy xmt_test_question" do
    assert_difference('XmtTest::Question.count', -1) do
      delete xmt_test_question_url(@xmt_test_question)
    end

    assert_redirected_to xmt_test_questions_url
  end
end
