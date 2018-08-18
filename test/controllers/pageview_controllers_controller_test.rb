require 'test_helper'

class PageviewControllersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pageview_controller = pageview_controllers(:one)
  end

  test "should get index" do
    get pageview_controllers_url
    assert_response :success
  end

  test "should get new" do
    get new_pageview_controller_url
    assert_response :success
  end

  test "should create pageview_controller" do
    assert_difference('PageviewController.count') do
      post pageview_controllers_url, params: { pageview_controller: {  } }
    end

    assert_redirected_to pageview_controller_url(PageviewController.last)
  end

  test "should show pageview_controller" do
    get pageview_controller_url(@pageview_controller)
    assert_response :success
  end

  test "should get edit" do
    get edit_pageview_controller_url(@pageview_controller)
    assert_response :success
  end

  test "should update pageview_controller" do
    patch pageview_controller_url(@pageview_controller), params: { pageview_controller: {  } }
    assert_redirected_to pageview_controller_url(@pageview_controller)
  end

  test "should destroy pageview_controller" do
    assert_difference('PageviewController.count', -1) do
      delete pageview_controller_url(@pageview_controller)
    end

    assert_redirected_to pageview_controllers_url
  end
end
