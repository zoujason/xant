require 'test_helper'

class Xmt::Press::SensitivesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xmt_press_sensitive = xmt_press_sensitives(:one)
  end

  test "should get index" do
    get xmt_press_sensitives_url
    assert_response :success
  end

  test "should get new" do
    get new_xmt_press_sensitive_url
    assert_response :success
  end

  test "should create xmt_press_sensitive" do
    assert_difference('Xmt::Press::Sensitive.count') do
      post xmt_press_sensitives_url, params: { xmt_press_sensitive: {  } }
    end

    assert_redirected_to xmt_press_sensitive_url(Xmt::Press::Sensitive.last)
  end

  test "should show xmt_press_sensitive" do
    get xmt_press_sensitive_url(@xmt_press_sensitive)
    assert_response :success
  end

  test "should get edit" do
    get edit_xmt_press_sensitive_url(@xmt_press_sensitive)
    assert_response :success
  end

  test "should update xmt_press_sensitive" do
    patch xmt_press_sensitive_url(@xmt_press_sensitive), params: { xmt_press_sensitive: {  } }
    assert_redirected_to xmt_press_sensitive_url(@xmt_press_sensitive)
  end

  test "should destroy xmt_press_sensitive" do
    assert_difference('Xmt::Press::Sensitive.count', -1) do
      delete xmt_press_sensitive_url(@xmt_press_sensitive)
    end

    assert_redirected_to xmt_press_sensitives_url
  end
end
