require 'test_helper'

class Xmt::Faq::ConsultationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xmt_faq_consultation = xmt_faq_consultations(:one)
  end

  test "should get index" do
    get xmt_faq_consultations_url
    assert_response :success
  end

  test "should get new" do
    get new_xmt_faq_consultation_url
    assert_response :success
  end

  test "should create xmt_faq_consultation" do
    assert_difference('Xmt::Faq::Consultation.count') do
      post xmt_faq_consultations_url, params: { xmt_faq_consultation: {  } }
    end

    assert_redirected_to xmt_faq_consultation_url(Xmt::Faq::Consultation.last)
  end

  test "should show xmt_faq_consultation" do
    get xmt_faq_consultation_url(@xmt_faq_consultation)
    assert_response :success
  end

  test "should get edit" do
    get edit_xmt_faq_consultation_url(@xmt_faq_consultation)
    assert_response :success
  end

  test "should update xmt_faq_consultation" do
    patch xmt_faq_consultation_url(@xmt_faq_consultation), params: { xmt_faq_consultation: {  } }
    assert_redirected_to xmt_faq_consultation_url(@xmt_faq_consultation)
  end

  test "should destroy xmt_faq_consultation" do
    assert_difference('Xmt::Faq::Consultation.count', -1) do
      delete xmt_faq_consultation_url(@xmt_faq_consultation)
    end

    assert_redirected_to xmt_faq_consultations_url
  end
end
