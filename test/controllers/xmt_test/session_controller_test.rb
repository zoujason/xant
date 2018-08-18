require 'test_helper'

class XmtTest::SessionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get xmt_test_session_new_url
    assert_response :success
  end

end
