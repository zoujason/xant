require 'test_helper'

class Xmt::Press::RefTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xmt_press_ref_type = xmt_press_ref_types(:one)
  end

  test "should get index" do
    get xmt_press_ref_types_url
    assert_response :success
  end

  test "should get new" do
    get new_xmt_press_ref_type_url
    assert_response :success
  end

  test "should create xmt_press_ref_type" do
    assert_difference('Xmt::Press::RefType.count') do
      post xmt_press_ref_types_url, params: { xmt_press_ref_type: {  } }
    end

    assert_redirected_to xmt_press_ref_type_url(Xmt::Press::RefType.last)
  end

  test "should show xmt_press_ref_type" do
    get xmt_press_ref_type_url(@xmt_press_ref_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_xmt_press_ref_type_url(@xmt_press_ref_type)
    assert_response :success
  end

  test "should update xmt_press_ref_type" do
    patch xmt_press_ref_type_url(@xmt_press_ref_type), params: { xmt_press_ref_type: {  } }
    assert_redirected_to xmt_press_ref_type_url(@xmt_press_ref_type)
  end

  test "should destroy xmt_press_ref_type" do
    assert_difference('Xmt::Press::RefType.count', -1) do
      delete xmt_press_ref_type_url(@xmt_press_ref_type)
    end

    assert_redirected_to xmt_press_ref_types_url
  end
end
