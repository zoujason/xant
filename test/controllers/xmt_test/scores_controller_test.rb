require 'test_helper'

class XmtTest::ScoresControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get xmt_test_scores_new_url
    assert_response :success
  end

  test "should get show" do
    get xmt_test_scores_show_url
    assert_response :success
  end

end
