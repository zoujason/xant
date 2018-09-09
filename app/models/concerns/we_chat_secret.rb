require "net/https"
require "uri"
require 'json'
require "base64"
require 'openssl'
#require './wx_app'
class WeChatSecret
  NUM_AND_CHARS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  #
  # @@corp_id = 'wx60ca805fd5a50851'
  # @@corp_secret = ['M3pmcDZQUQppw2oChPfeMNf4xKRA6T2LeHOpzu0_qo4', 'V_7VDTMLEHKh58mEfYe-s1EZ40b4tpVAZG8HxqFnuDQ']
  # @@access_token_url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=#{@@corp_id}&corpsecret=#{@@corp_secret}"
  #
  # @@access_token_notice_value = ["",0]
  # @@access_token_appeal_value = ["",0]


  @@encoding_aes_key = 'UdGTEr8TphhbHO4dznTiSxcSEcczRpAKwSijwGBLzYf'
  @@aes_key = Base64.decode64(@@encoding_aes_key + '=')

  def self.wget(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response.body
  end

  def self.wpost_json(url, data)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(url, {'Content-Type' => 'application/json'})
    request.body = data.to_json
    response = http.request(request)
    response.body
  end


  def self.get_access_token(objectname)
     ::WXApp.create(objectname).get_token
  end


  def self.set_oauth_url(redirect_uri, scope, agentid)
    state = (0...16).map { NUM_AND_CHARS[rand(NUM_AND_CHARS.length)] }.join
    oauth_url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{@@corp_id}&redirect_uri=#{URI.encode(redirect_uri)}&response_type=code&scope=#{scope}&agentid=#{agentid}&state==#{state}#wechat_redirect"
    oauth_url
  end


  def self.get_user_info(code)
    userinfo_url = "https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token=#{get_access_token(:notice)}&code=#{code}"
    resp = JSON.parse(self.wget(userinfo_url))
    resp
  end

  def self.get_user_detail(user_ticket)
    userdetail_url = "https://qyapi.weixin.qq.com/cgi-bin/user/getuserdetail?access_token=#{get_access_token(:notice)}"
    data = {"user_ticket": user_ticket}
    resp = JSON.parse(self.wpost_json(userdetail_url, data))
    resp
  end

  # action = :encrypt or :decrypt
  def self.aes(action, key, text)
    cipher = OpenSSL::Cipher.new('AES-256-CBC')
    cipher.send(action)
    cipher.padding = 0
    cipher.key = key
    cipher.iv = key[0...16]
    cipher.update(text) + cipher.final
  end

  def self.decode(text)
    pad = text[-1].ord
    pad = 0 if (pad < 1 || pad > 32)
    size = text.size - pad
    text[0...size]
  end


  def self.decrypt(echostr)
    text = Base64.decode64(echostr)
    text = WeChatSecret.aes(:decrypt, @@aes_key, text)
    text = decode(text)
    content = text[16...text.length]
    len_list = content[0...4].unpack("N")
    xml_len = len_list[0]
    xml_content = content[4...4 + xml_len]
    from_corpid = content[xml_len+4...content.size]
    if @@corp_id != from_corpid
      Rails.logger.debug("#{__FILE__}:#{__LINE__} Failure because #{@@corp_id} != #{from_corpid}")
      status = 401
    end
    status = 200
    [xml_content, status]
  end


  def self.send_message(data,name)
    send_message_url = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=#{get_access_token(name)}"
    message_status = JSON.parse(self.wpost_json(send_message_url, data))
    message_status

  end



  def self.get_dept_list(deptid)
    dept_array = []
    dept_list_url = "https://qyapi.weixin.qq.com/cgi-bin/department/list?access_token=#{get_access_token(:tongxun)}&id=#{deptid}"
    dept_list = JSON.parse(self.wget(dept_list_url))
  end



  def self.update_dept_wechat(data)
    update_dept_url = "https://qyapi.weixin.qq.com/cgi-bin/department/update?access_token=#{get_access_token(:tongxun)}"
    dept_list = JSON.parse(self.wpost_json(update_dept_url,data))
  end

  def self.create_dept_wechat(data)
    update_dept_url = "https://qyapi.weixin.qq.com/cgi-bin/department/create?access_token=#{get_access_token(:tongxun)}"
    dept_list = JSON.parse(self.wpost_json(update_dept_url,data))
  end


  def self.delete_dept(id)
    dept_array = []
    dept_url = "https://qyapi.weixin.qq.com/cgi-bin/department/delete?access_token=#{get_access_token(:tongxun)}&id=#{id}"
    dept_list = JSON.parse(self.wget(dept_url))
  end



  def self.get_user(userid)
    dept_array = []
    user_info_url = "https://qyapi.weixin.qq.com/cgi-bin/user/get?access_token=#{get_access_token(:tongxun)}&userid=#{userid}"
    dept_list = JSON.parse(self.wget(user_info_url))
  end




  def self.create_user(data)
    user_url = "https://qyapi.weixin.qq.com/cgi-bin/user/create?access_token=#{get_access_token(:tongxun)}"
    user_list = JSON.parse(self.wpost_json(user_url,data))
  end

  def self.update_user(data)
    user_url = "https://qyapi.weixin.qq.com/cgi-bin/user/update?access_token=#{get_access_token(:tongxun)}"
    user_list = JSON.parse(self.wpost_json(user_url,data))
  end


  def self.delete_user(userid)
    dept_array = []
    user_info_url = "https://qyapi.weixin.qq.com/cgi-bin/user/delete?access_token=#{get_access_token(:tongxun)}&userid=#{userid}"
    dept_list = JSON.parse(self.wget(user_info_url))
  end


  def self.get_dept_user(deptid)
    dept_array = []
    user_info_url = "https://qyapi.weixin.qq.com/cgi-bin/user/list?access_token=#{get_access_token(:tongxun)}&department_id=#{deptid}&fetch_child=0"
    dept_list = JSON.parse(self.wget(user_info_url))
  end


end

if __FILE__ == $0
  # WeChatSecret.update_user({"userid":"zhangsanss","name":"张四","mobile":"15845689798","department":2})
  data ={
      "touser": "lhyao",
      "toparty": "",
      "totag": "",
      "msgtype": "news",
      "agentid": 1000002,
      "news": {
          "articles":[
              {
                  "title": "#{Time.now.strftime("%Y")}年#{Time.now.strftime("%m").to_i==1 ? 12 : Time.now.strftime("%m").to_i-1}月工资发放通知",
                  "description": "#{Time.now.strftime("%Y")}年#{Time.now.strftime("%m").to_i==1 ? 12 : Time.now.strftime("%m").to_i-1}月工资已发放,请注意查收,有问题,请及时联系财务.",
                  "url": "http://gbdsdx.hljgov.com/salaries",
                  "picurl": "http://test.hljgov.com/notices01.png"
              }
          ]
      }
  }
  p WeChatSecret.send_message(data,:notice)
 #p WeChatSecret.get_dept_list(1)
  #p WeChatSecret.get_access_token(:notice)
  # WXApp.new("wxf129b2f2bf0fc5a5","QxhiupLVgmajRE1lVvYvrOWSm37IENqg_8iVCKt-u0Q").get_access_token
  # #   # Notification.find_by(id:"594cab486df5eb1bfc7e2b6f")
  # #    #p WeChatSecret.set_oauth_url('http://http://test.hljgov.com/', 'snsapi_userinfo', 6)request.request_uri
  # #   #p WeChatSecret.decrypt('ILGWenzhrmyg3SkYFOHO6E/McRJVJo8DnXzAev4Me1iBu20Idv2a9WNPVa3wNB9rfWaeEgAfQHaqdoTiIwWz2Q').to_s.force_encoding("UTF-8")
end

