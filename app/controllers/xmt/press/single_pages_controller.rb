module Xmt
  module Press
    class SinglePagesController < AdminController
      before_action :set_singlepage, only: [:show, :edit, :update, :destroy]
      before_action :set_site

      # GET /xmt/singlepages
      # GET /xmt/singlepages.json
      def index
        @singlepages = SinglePage.where(parent_id: @site.try(:id)).page(params[:page]).per(10)
      end

      # GET /xmt/singlepages/1
      # GET /xmt/singlepages/1.json
      def show
      end

      # GET /xmt/singlepages/new
      def new
        @singlepage = SinglePage.new
      end

      # GET /xmt/singlepages/1/edit
      def edit
      end

      # POST /xmt/singlepages
      # POST /xmt/singlepages.json
      def create
        @singlepage = SinglePage.new(singlepage_params)

        respond_to do |format|
          if @singlepage.save
            format.html {redirect_to xmt_press_single_pages_url(site_id: @site.id), notice: '单页添加成功.'}
            format.json {render :show, status: :created, location: @xmt_press_single_page}
          else
            format.html {render :new}
            format.json {render json: @singlepage.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/singlepages/1
      # PATCH/PUT /xmt/singlepages/1.json
      def update
        respond_to do |format|
          if @singlepage.update(singlepage_params)
            format.html {redirect_to xmt_press_single_pages_url(site_id: @site.id), notice: '单页修改成功.'}
            format.json {render :show, status: :ok, location: @xmt_press_singlepage}
          else
            format.html {render :edit}
            format.json {render json: @singlepage.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/singlepages/1
      # DELETE /xmt/singlepages/1.json
      def destroy
        @singlepage.destroy
        respond_to do |format|
          format.html {redirect_to xmt_press_single_pages_url(site_id: @site.id), notice: '单页删除成功.'}
          format.json {head :no_content}
        end
      end


      def rdf_type
        @rdftype = Xmt::Press::PageType.find(params[:rid])
        render json:@rdftype
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_singlepage
        @singlepage = SinglePage.find(params[:id])
      end

      def set_site
        @sites = Site.all
        @site = params[:site_id].blank? ? @sites.first : Site.find(params[:site_id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def singlepage_params
        params.require(:xmt_press_single_page).permit!
      end
    end
  end
end

