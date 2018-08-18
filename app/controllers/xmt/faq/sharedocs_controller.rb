module Xmt
  module Faq
    class SharedocsController < AdminController
      before_action :set_sharedoc, only: [:show, :edit, :update, :destroy]
      before_action :set_site
      # GET /xmt_mgr/information
      # GET /xmt_mgr/information.json
      def index
        @sites = Xmt::Press::Site.all.to_a
        opts = {}
        opts[:site_id] = params[:site_id].blank? ? @site.id : params[:site_id]
        opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?
        opts[:checked] = params[:checked] unless params[:checked].blank?
        @sharedocs = Xmt::Faq::Sharedoc.where(opts).order(created_at: :desc).page(params[:page])

      end

      # GET /xmt_mgr/information/1
      # GET /xmt_mgr/information/1.json
      def show
      end

      # GET /xmt_mgr/information/new
      def new
        @sharedoc = Xmt::Faq::Sharedoc.new
      end

      # GET /xmt_mgr/information/1/edit
      def edit
      end

      # POST /xmt_mgr/information
      # POST /xmt_mgr/information.json
      def create
        @sharedoc = Xmt::Faq::Sharedoc.new(sharedoc_params)

        respond_to do |format|
          if @sharedoc.save
            format.html { redirect_to xmt_faq_sharedocs_url(site:sharedoc_params[:site_id]), notice: '创建成功' }
            format.json { render :show, status: :created, location: @information }
          else
            format.html { render :new }
            format.json { render json: @information.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /xmt_mgr/information/1
      # PATCH/PUT /xmt_mgr/information/1.json
      def update
        respond_to do |format|
          if @sharedoc.update(sharedoc_params)
            format.html { redirect_to xmt_faq_sharedocs_url(site:sharedoc_params[:site_id]), notice: '回复成功' }
            format.json { render :show, status: :ok, location: @information }
          else
            format.html { render :edit }
            format.json { render json: @information.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /xmt_mgr/information/1
      # DELETE /xmt_mgr/information/1.json
      def destroy
        @sharedoc.destroy
        respond_to do |format|
          format.html { redirect_to xmt_faq_sharedocs_url(site:params[:site_id]), notice: '删除成功' }
          format.json { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_sharedoc
        @sharedoc = Xmt::Faq::Sharedoc.find(params[:id])
      end

      def set_site
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def sharedoc_params
        params.require(:xmt_faq_sharedoc).permit!

      end
    end
  end
end


