class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authc_init

  def authc_init
    Waas::Security.init(self)
  end

  def subject
    Waas::Security.subject
  end

  helper_method :subject

end
