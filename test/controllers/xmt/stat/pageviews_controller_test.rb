require 'test_helper'

class Xmt::Stat::PageviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xmt_stat_pageview = xmt_stat_pageviews(:one)
  end

  test "should get index" do
    get xmt_stat_pageviews_url
    assert_response :success
  end

  test "should get new" do
    get new_xmt_stat_pageview_url
    assert_response :success
  end

  test "should create xmt_stat_pageview" do
    assert_difference('Xmt::Stat::Pageview.count') do
      post xmt_stat_pageviews_url, params: { xmt_stat_pageview: {  } }
    end

    assert_redirected_to xmt_stat_pageview_url(Xmt::Stat::Pageview.last)
  end

  test "should show xmt_stat_pageview" do
    get xmt_stat_pageview_url(@xmt_stat_pageview)
    assert_response :success
  end

  test "should get edit" do
    get edit_xmt_stat_pageview_url(@xmt_stat_pageview)
    assert_response :success
  end

  test "should update xmt_stat_pageview" do
    patch xmt_stat_pageview_url(@xmt_stat_pageview), params: { xmt_stat_pageview: {  } }
    assert_redirected_to xmt_stat_pageview_url(@xmt_stat_pageview)
  end

  test "should destroy xmt_stat_pageview" do
    assert_difference('Xmt::Stat::Pageview.count', -1) do
      delete xmt_stat_pageview_url(@xmt_stat_pageview)
    end

    assert_redirected_to xmt_stat_pageviews_url
  end
end
