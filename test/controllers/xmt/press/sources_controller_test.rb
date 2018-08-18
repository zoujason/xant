require 'test_helper'

class Xmt::Press::SourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xmt_press_source = xmt_press_sources(:one)
  end

  test "should get index" do
    get xmt_press_sources_url
    assert_response :success
  end

  test "should get new" do
    get new_xmt_press_source_url
    assert_response :success
  end

  test "should create xmt_press_source" do
    assert_difference('Xmt::Press::Source.count') do
      post xmt_press_sources_url, params: { xmt_press_source: {  } }
    end

    assert_redirected_to xmt_press_source_url(Xmt::Press::Source.last)
  end

  test "should show xmt_press_source" do
    get xmt_press_source_url(@xmt_press_source)
    assert_response :success
  end

  test "should get edit" do
    get edit_xmt_press_source_url(@xmt_press_source)
    assert_response :success
  end

  test "should update xmt_press_source" do
    patch xmt_press_source_url(@xmt_press_source), params: { xmt_press_source: {  } }
    assert_redirected_to xmt_press_source_url(@xmt_press_source)
  end

  test "should destroy xmt_press_source" do
    assert_difference('Xmt::Press::Source.count', -1) do
      delete xmt_press_source_url(@xmt_press_source)
    end

    assert_redirected_to xmt_press_sources_url
  end
end
