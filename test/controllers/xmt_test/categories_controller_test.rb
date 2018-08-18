require 'test_helper'

class XmtTest::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xmt_test_category = xmt_test_categories(:one)
  end

  test "should get index" do
    get xmt_test_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_xmt_test_category_url
    assert_response :success
  end

  test "should create xmt_test_category" do
    assert_difference('XmtTest::Category.count') do
      post xmt_test_categories_url, params: { xmt_test_category: {  } }
    end

    assert_redirected_to xmt_test_category_url(XmtTest::Category.last)
  end

  test "should show xmt_test_category" do
    get xmt_test_category_url(@xmt_test_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_xmt_test_category_url(@xmt_test_category)
    assert_response :success
  end

  test "should update xmt_test_category" do
    patch xmt_test_category_url(@xmt_test_category), params: { xmt_test_category: {  } }
    assert_redirected_to xmt_test_category_url(@xmt_test_category)
  end

  test "should destroy xmt_test_category" do
    assert_difference('XmtTest::Category.count', -1) do
      delete xmt_test_category_url(@xmt_test_category)
    end

    assert_redirected_to xmt_test_categories_url
  end
end
