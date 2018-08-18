require 'test_helper'

class GbooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gbook_type = gbooks(:one)
  end

  test "should get index" do
    get gbookTypeTypes_url
    assert_response :success
  end

  test "should get new" do
    get new_gbookType_url
    assert_response :success
  end

  test "should create gbook" do
    assert_difference('Gbook.count') do
      post gbookTypeTypes_url, params: {gbook: {  } }
    end

    assert_redirected_to gbookType_url(GbookType.last)
  end

  test "should show gbook" do
    get gbookType_url(@gbook_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_gbookType_url(@gbook_type)
    assert_response :success
  end

  test "should update gbook" do
    patch gbookType_url(@gbook), params: {gbook_type: {  } }
    assert_redirected_to gbookType_url(@gbook_type)
  end

  test "should destroy gbook" do
    assert_difference('Gbook.count', -1) do
      delete gbookType_url(@gbook_type)
    end

    assert_redirected_to gbookTypeTypes_url
  end
end
