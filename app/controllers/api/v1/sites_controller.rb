module Api
  module V1
    class SitesController < BaseController

      def index
        opts = {parent_id: params[:slug]}.delete_if {|key, value| value.blank? }
        @sites = Site.where(opts).page(params[:page])
      end

      def show
        @site = Site.find(params[:id])

      end

    end
  end
end
