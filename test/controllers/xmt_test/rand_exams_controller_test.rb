require 'test_helper'

class XmtTest::RandExamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xmt_test_rand_exam = xmt_test_rand_exams(:one)
  end

  test "should get index" do
    get xmt_test_rand_exams_url
    assert_response :success
  end

  test "should get new" do
    get new_xmt_test_rand_exam_url
    assert_response :success
  end

  test "should create xmt_test_rand_exam" do
    assert_difference('XmtTest::RandExam.count') do
      post xmt_test_rand_exams_url, params: { xmt_test_rand_exam: {  } }
    end

    assert_redirected_to xmt_test_rand_exam_url(XmtTest::RandExam.last)
  end

  test "should show xmt_test_rand_exam" do
    get xmt_test_rand_exam_url(@xmt_test_rand_exam)
    assert_response :success
  end

  test "should get edit" do
    get edit_xmt_test_rand_exam_url(@xmt_test_rand_exam)
    assert_response :success
  end

  test "should update xmt_test_rand_exam" do
    patch xmt_test_rand_exam_url(@xmt_test_rand_exam), params: { xmt_test_rand_exam: {  } }
    assert_redirected_to xmt_test_rand_exam_url(@xmt_test_rand_exam)
  end

  test "should destroy xmt_test_rand_exam" do
    assert_difference('XmtTest::RandExam.count', -1) do
      delete xmt_test_rand_exam_url(@xmt_test_rand_exam)
    end

    assert_redirected_to xmt_test_rand_exams_url
  end
end
