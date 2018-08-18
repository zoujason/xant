require 'test_helper'

class Xmt::Stat::PageViewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xmt_stat_page_view = xmt_stat_page_views(:one)
  end

  test "should get index" do
    get xmt_stat_page_views_url
    assert_response :success
  end

  test "should get new" do
    get new_xmt_stat_page_view_url
    assert_response :success
  end

  test "should create xmt_stat_page_view" do
    assert_difference('Xmt::Stat::PageView.count') do
      post xmt_stat_page_views_url, params: { xmt_stat_page_view: {  } }
    end

    assert_redirected_to xmt_stat_page_view_url(Xmt::Stat::PageView.last)
  end

  test "should show xmt_stat_page_view" do
    get xmt_stat_page_view_url(@xmt_stat_page_view)
    assert_response :success
  end

  test "should get edit" do
    get edit_xmt_stat_page_view_url(@xmt_stat_page_view)
    assert_response :success
  end

  test "should update xmt_stat_page_view" do
    patch xmt_stat_page_view_url(@xmt_stat_page_view), params: { xmt_stat_page_view: {  } }
    assert_redirected_to xmt_stat_page_view_url(@xmt_stat_page_view)
  end

  test "should destroy xmt_stat_page_view" do
    assert_difference('Xmt::Stat::PageView.count', -1) do
      delete xmt_stat_page_view_url(@xmt_stat_page_view)
    end

    assert_redirected_to xmt_stat_page_views_url
  end
end
