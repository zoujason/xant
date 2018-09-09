require "net/https"
require "uri"
require 'json'
require "base64"
require 'openssl'

class WXApp
  @@access_token_url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=%s&corpsecret=%s"

  attr_reader :corp_id, :secret_id, :token

  def self.wget(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response.body
  end

  def self.create(name)
    @@apps ||= {
        notice: WXApp.new("ww67b3e8b63f53b569","CsvoE9JzzNCl0VUfP4mKjX6yZyVpMbKqNpZpxyPFrdY"),
        salary: WXApp.new("ww67b3e8b63f53b569","4F-9kz0g4rlr6LPW1enz5-c9mtIve1vmqvguMsjGolQ"),
        tongxun: WXApp.new("ww67b3e8b63f53b569","crii07kRiVH48ffkORS0O6l5hif-72pZSN8gaBwVmlA"),
        totalform: WXApp.new("ww67b3e8b63f53b569","oCtPldNmH6uummw31Oopd5cPEvEsOgLah1iLl-xh-bw")
    }
    @@apps[name]
  end

  def initialize(corp_id, secret_id)
    @corp_id = corp_id || ''
    @secret_id = secret_id || ''
    @token = {access_token: '', expires_in: 0}
  end

  def update_token
    url = format(@@access_token_url, @corp_id, @secret_id)
    resp = JSON.parse(WXApp.wget(url))
    if resp["errcode"] == 0
      @token[:access_token] = resp["access_token"]
      @token[:expires_in] = resp["expires_in"] + Time.now.to_i
    end
  end

  def get_token
    if @token[:expires_in] < Time.now.to_i
      update_token
    end
    @token[:access_token]
  end
end