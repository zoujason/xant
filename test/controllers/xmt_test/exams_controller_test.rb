require 'test_helper'

class XmtTest::ExamsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get xmt_test_exams_new_url
    assert_response :success
  end

end
