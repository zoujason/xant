require 'test_helper'

class PageTest < ActionDispatch::IntegrationTest
  setup do
    @mgr = Manager.create username: 'admin', password: 'admin123', datatype: :sys
  end

  test "the truth" do
    visit('/xmt/sessions/new')
    assert page.has_content?('登录到您的帐户')
    p page.current_path
    fill_in('username', with: 'admin')
    fill_in('password', with: 'admin123')
    click_button '登录'
    p page.html
    assert page.has_content?('退出')

  end

  teardown do
    @mgr.delete
  end
end
