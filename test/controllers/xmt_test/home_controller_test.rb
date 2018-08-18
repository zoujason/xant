require 'test_helper'

class XmtTest::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get xmt_test_home_index_url
    assert_response :success
  end

end
