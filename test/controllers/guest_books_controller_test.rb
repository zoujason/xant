require 'test_helper'

class GuestBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @guest_book = guest_books(:one)
  end

  test "should get index" do
    get guest_books_url
    assert_response :success
  end

  test "should get new" do
    get new_guest_book_url
    assert_response :success
  end

  test "should create guest_book" do
    assert_difference('GuestBook.count') do
      post guest_books_url, params: { guest_book: {  } }
    end

    assert_redirected_to guest_book_url(GuestBook.last)
  end

  test "should show guest_book" do
    get guest_book_url(@guest_book)
    assert_response :success
  end

  test "should get edit" do
    get edit_guest_book_url(@guest_book)
    assert_response :success
  end

  test "should update guest_book" do
    patch guest_book_url(@guest_book), params: { guest_book: {  } }
    assert_redirected_to guest_book_url(@guest_book)
  end

  test "should destroy guest_book" do
    assert_difference('GuestBook.count', -1) do
      delete guest_book_url(@guest_book)
    end

    assert_redirected_to guest_books_url
  end
end
