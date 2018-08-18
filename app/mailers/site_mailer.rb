class SiteMailer < ApplicationMailer
  after_action :set_smtp

  def delivery_options
    {   :address => "smtp.163.com",
        :port => 25,
        :domain => "163.com",
        :authentication => :login,
        :user_name => "ee@163.com",
        :password => "",
        :enable_starttls_auto => true
    }
  end

  # def mpp(member)
  #   @member = member
  #   #@con = "感谢你对科普龙江网的支持！你已注册成功。感谢你的关注,祝你生活愉快！"
  #   #@username = username
  #   #@password = password
  #   mail to: address, subject: "感谢你对科普龙江网的支持！你已注册成功，感谢你的关注！", delivery_method_options: delivery_options
  # end

  def notice_forget(member)
    @member=  member

    #@con = "你正在找回密码：请点击链接<a href='/pages/58a016d76df5eb2b5093ca45?uid=#{@member.id}'>修改密码</a>"
    mail to: member.email, subject: "你正在找回密码"
  end

  private
  def set_smtp
    mail.delivery_method.settings.merge!({   :address => "smtp.163.com",
                                             :port => 25,
                                             :domain => "163.com",
                                             :authentication => :login,
                                             :user_name => "sgzhe@163.com",
                                             :password => "12345qaw",
                                             :enable_starttls_auto => true
                                         })


  # mail.delivery_method.settings.merge!({
  #                                          address:              'smtp.qq.com',
  #                                          port:                 25,
  #                                          domain:               'smtp.qq.com',
  #                                          user_name:            '1058481110@qq.com',
  #                                          password:             '89905060zxl211',
  #                                          authentication:       'plain'
  #                                      })
  end
end