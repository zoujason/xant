# encoding: utf-8
module Xmt
  module Ad
    class AdvertisementsController < AdminController
      before_action :set_advertisement, only: [:show, :edit, :update, :destroy]
      before_action :set_site
      # GET /xmt/ad/advertisements
      # GET /xmt/ad/advertisements.json
      def index
        @site ||= @sites.first
        @advertisements = Advertisement.where(site_id: @site.id).page(params[:page])
        unless params[:key].blank?
          key = /.*#{params[:key]}.*/
          @advertisements = @advertisements.where(title: key).page(params[:page])
        end
      end

      # GET /xmt/ad/advertisements/1
      # GET /xmt/ad/advertisements/1.json
      def show
      end

      # GET /xmt/ad/advertisements/new
      def new
        @advertisement = Advertisement.new
      end

      # GET /xmt/ad/advertisements/1/edit
      def edit
      end

      # POST /xmt/ad/advertisements
      # POST /xmt/ad/advertisements.json
      def create
        @advertisement = Advertisement.new(advertisement_params)

        respond_to do |format|
          if @advertisement.save
            format.html {redirect_to xmt_ad_advertisements_url(site_id: @site.id), notice: '广告添加完成'}
            format.json {render :show, status: :created, location: @advertisement}
          else
            format.html {render :new}
            format.json {render json: @advertisement.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/ad/advertisements/1
      # PATCH/PUT /xmt/ad/advertisements/1.json
      def update
        respond_to do |format|
          if @advertisement.update(advertisement_params)
            format.html {redirect_to xmt_ad_advertisements_url(site_id: @site.id), notice: '广告修改完成'}
            format.json {render :show, status: :ok, location: @advertisement}
          else
            format.html {render :edit}
            format.json {render json: @advertisement.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/ad/advertisements/1
      # DELETE /xmt/ad/advertisements/1.json
      def destroy
        @advertisement.destroy
        respond_to do |format|
          format.html {redirect_to xmt_ad_advertisements_url(site_id: @site.id), notice: '广告删除完成'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_advertisement
        @advertisement = Advertisement.find(params[:id])
      end

      def set_site
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
      end
      # Never trust parameters from the scary internet, only allow the white list through.
      def advertisement_params
        params.require(:xmt_ad_advertisement).permit!
      end
    end
  end
end
