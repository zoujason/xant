module Xmt
  module Press
    class SitesController < AdminController
      before_action :set_site, only: [:show, :edit, :update, :destroy]

      # GET /xmt/sites
      # GET /xmt/sites.json
      def index
        @sites = Xmt::Press::Site.all.page(params[:page])
        unless params[:key].blank?
          key = /.*#{params[:key]}.*/
          @sites = @sites.where(title: key).page(params[:page])
        end
      end

      # GET /xmt/sites/1
      # GET /xmt/sites/1.json
      def show
      end

      # GET /xmt/sites/new
      def new
        @site = Xmt::Press::Site.new
      end

      # GET /xmt/sites/1/edit
      def edit
      end

      # POST /xmt/sites
      # POST /xmt/sites.json
      def create
        @site = Xmt::Press::Site.new(site_params)
        respond_to do |format|
          if @site.save
            format.html { redirect_to xmt_press_sites_url, notice: '站点创建成功.' }
            format.json { render :show, status: :created, location: @site }
          else
            format.html { render :new }
            format.json { render json: @site.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /xmt/sites/1
      # PATCH/PUT /xmt/sites/1.json
      def update
        respond_to do |format|
          if @site.update(site_params)
            format.html { redirect_to xmt_press_sites_url, notice: '站点更新成功.' }
            format.json { render :show, status: :ok, location: @site }
          else
            format.html { render :edit }
            format.json { render json: @site.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /xmt/sites/1
      # DELETE /xmt/sites/1.json
      def destroy
        @site.destroy
        respond_to do |format|
          format.html { redirect_to xmt_press_sites_url, notice: '站点删除成功.' }
          format.json { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_site
        @site = Xmt::Press::Site.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def site_params
        params.require(:xmt_press_site).permit!
      end
    end

  end
end