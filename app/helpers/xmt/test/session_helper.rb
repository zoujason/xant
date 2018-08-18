module Xmt::Test::SessionHelper

  def log_in(user)
    session[:xmt_test_user_id] = user.id
  end

  def current_user
    @current_user = nil
    @current_user ||= Xmt::Staff::User.find_by(id: session[:xmt_test_user_id]) if session[:xmt_test_user_id]
  end

  def current_user?(user)
    user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:xmt_test_user_id)
    @current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url]||default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
