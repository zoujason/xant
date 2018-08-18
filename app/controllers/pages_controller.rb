class PagesController < ApplicationController
  before_action :set_page
  before_action :setup_view_paths
  layout :setup_layout

  def index
    render plain:Xmt::Press::Page.all.to_json and return
    render layout: @page.site.cont_layout, template: @page.site.cont_tpl
  end


  # GET /pages/1
  def show
    if @page.has_caching?
      render html: @page.caching_data.html_safe
    else
      cont_layout =  @page.cont_layout
      cont_tpl = @page.cont_tpl

      if @page.site.mobile && mobile?
        cont_tpl, cont_layout = "m_#{cont_tpl}" , "m_#{cont_layout}"
      end
      render layout: cont_layout, template: cont_tpl
      @page.update_caching(response.body)
    end
  end

  private
  def set_page
    @page = Xmt::Press::Page.where(id: params[:id]).first unless params[:id].blank?
    @page = SiteMgr.instance.find_or_default_by_slug(params[:slug]) unless @page
    @site = @page.site
    imprint
  end

  def setup_view_paths
    prepend_view_path "app/sites/#{@page.site.theme || @page.site.slug}/views/"
  end

  def setup_layout
   # request.format = :mobile if mobile?
    @site.layout
  end

  def mobile?
    @mobile ||= request.user_agent && request.user_agent.downcase =~ /mobile|iphone|webos|android|blackberry|midp|cldc/ && request.user_agent.downcase !~ /ipad/
  end

  def imprint
    options = {
        ip: request.remote_ip,
        referer: request.referer,
        url: request.url,
        uv_id: session.id,
        title: @page.title,
        page: @page
    }
    Xmt::Stat::Tracker.imprint(options)
  end



end
