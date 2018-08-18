require 'test_helper'

class XmtTest::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get xmt_test_users_new_url
    assert_response :success
  end

end
