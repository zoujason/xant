require "net/https"
require "uri"
require 'json'
require 'digest/sha1'

class WeChat
  NUM_AND_CHARS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  # NUM_URL3 = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx31eada1676ae1ceb&redirect_uri=http://qgtp.hljgov.com/articles/getopenid&response_type=code&scope=snsapi_userinfo&state=12345#wechat_redirect"
  NUM_URL1 = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx31eada1676ae1ceb&redirect_uri=http%3a%2f%2fqgtp.hljgov.com%2farticles%2fgetopenid&response_type=code&scope=snsapi_base&state=123#wechat_redirect"
  NUM_URL2 = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx31eada1676ae1ceb%26redirect_uri=http%3a%2f%2fqgtp.hljgov.com%2farticles%2fgetopenid%26response_type=code%26scope=snsapi_base%26state=1234#wechat_redirect"
  @@appid = 'wx31eada1676ae1ceb'
  @@secret = 'b746a5610ee0c052efa5ed02ee85cf89'





  def self.wget(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response.body
  end

  def self.get_openid(code)
    url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx31eada1676ae1ceb&secret=b746a5610ee0c052efa5ed02ee85cf89&code=#{code}&grant_type=authorization_code"
    # resp = JSON.parse(self.wget(url))
    resp = self.wget(url)
    return resp
  end


end


if __FILE__ == $0
  p WeChat.signature('lllllllllllllllllllllllllll')

end

