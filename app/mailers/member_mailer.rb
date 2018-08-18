class MemberMailer < ApplicationMailer
  after_action :set_smtp

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.member_mailer.mpp.subject
  #
  def notice
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  private
  def set_smtp
    #mail.delivery_method.settings.merge!(@biz.smtp_settings)
  end
end
