require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 4
    assert @user.valid?, 'sssff'
    p @user.errors.full_messages.join()
  end

  # test "the truth" do
  #   assert true
  # end
end
