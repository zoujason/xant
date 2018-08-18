require 'test_helper'

class Xmt::Ad::AdvertisementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xmt_ad_advertisement = xmt_ad_advertisements(:one)
  end

  test "should get index" do
    get xmt_ad_advertisements_url
    assert_response :success
  end

  test "should get new" do
    get new_xmt_ad_advertisement_url
    assert_response :success
  end

  test "should create xmt_ad_advertisement" do
    assert_difference('Xmt::Ad::Advertisement.count') do
      post xmt_ad_advertisements_url, params: { xmt_ad_advertisement: {  } }
    end

    assert_redirected_to xmt_ad_advertisement_url(Xmt::Ad::Advertisement.last)
  end

  test "should show xmt_ad_advertisement" do
    get xmt_ad_advertisement_url(@xmt_ad_advertisement)
    assert_response :success
  end

  test "should get edit" do
    get edit_xmt_ad_advertisement_url(@xmt_ad_advertisement)
    assert_response :success
  end

  test "should update xmt_ad_advertisement" do
    patch xmt_ad_advertisement_url(@xmt_ad_advertisement), params: { xmt_ad_advertisement: {  } }
    assert_redirected_to xmt_ad_advertisement_url(@xmt_ad_advertisement)
  end

  test "should destroy xmt_ad_advertisement" do
    assert_difference('Xmt::Ad::Advertisement.count', -1) do
      delete xmt_ad_advertisement_url(@xmt_ad_advertisement)
    end

    assert_redirected_to xmt_ad_advertisements_url
  end
end
