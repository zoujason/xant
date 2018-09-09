class OauthwechatsController  < ApplicationController

  def index
    redirect_uri = "http://www.xpzeta.com/oauthwechats/new"
    url_code = WeChatClient.set_oauth2_url(redirect_uri,'snsapi_base')
    redirect_to url_code
  end


  def new
     # unless  params[:code].blank?
     #    resp =  WeChatClient.get_openid(params[:code])
     #    openid = resp['openid']
     #   redirect_to tickets_path(openid:openid)
     # end
  end

end
