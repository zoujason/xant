require 'test_helper'
class DefFormControllerTest < ActionDispatch::IntegrationTest
  setup do
    #@xmt_mgr_content = xmt_mgr_contents(:one)
  end
  test "should get index" do

    assert_response :success
  end


end