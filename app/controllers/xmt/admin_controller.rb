module Xmt
  class AdminController < ActionController::Base
    include Waas::AuthcFilter
    layout :set_layout
    before_action :set_site

    def index
      # @menu_table = ChannelUpdateBuilder.new(@site)
      # @menu_table.build
    end

    private
    def set_layout
      request.xhr? ? false : 'admin' # layout is false for ajax requests
    end

    def set_site
      @sites = AdminChannelMgr.instance.sites
      @site = AdminChannelMgr.instance.find_site(params[:site_id]) || AdminChannelMgr.instance.default_site
    end

  end
end
