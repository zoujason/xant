require 'test_helper'

class XmtTest::PapersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get xmt_test_papers_new_url
    assert_response :success
  end

end
