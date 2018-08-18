require 'test_helper'

class Xmt::Staff::DeptApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xmt_staff_dept_application = xmt_staff_dept_applications(:one)
  end

  test "should get index" do
    get xmt_staff_dept_applications_url
    assert_response :success
  end

  test "should get new" do
    get new_xmt_staff_dept_application_url
    assert_response :success
  end

  test "should create xmt_staff_dept_application" do
    assert_difference('Xmt::Staff::DeptApplication.count') do
      post xmt_staff_dept_applications_url, params: { xmt_staff_dept_application: {  } }
    end

    assert_redirected_to xmt_staff_dept_application_url(Xmt::Staff::DeptApplication.last)
  end

  test "should show xmt_staff_dept_application" do
    get xmt_staff_dept_application_url(@xmt_staff_dept_application)
    assert_response :success
  end

  test "should get edit" do
    get edit_xmt_staff_dept_application_url(@xmt_staff_dept_application)
    assert_response :success
  end

  test "should update xmt_staff_dept_application" do
    patch xmt_staff_dept_application_url(@xmt_staff_dept_application), params: { xmt_staff_dept_application: {  } }
    assert_redirected_to xmt_staff_dept_application_url(@xmt_staff_dept_application)
  end

  test "should destroy xmt_staff_dept_application" do
    assert_difference('Xmt::Staff::DeptApplication.count', -1) do
      delete xmt_staff_dept_application_url(@xmt_staff_dept_application)
    end

    assert_redirected_to xmt_staff_dept_applications_url
  end
end
