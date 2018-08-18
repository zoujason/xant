module Xmt
  module Asset
    class ScriptsController < AdminController
      before_action :set_script, only: [:edit, :destroy]
      before_action :set_site
      # GET /xmt/templates
      # GET /xmt/templates.json
      def index
        @scripts = Xmt::Asset::Script.all(@site.theme || @site.slug)
      end

      # GET /xmt/templates/1
      # GET /xmt/templates/1.json
      def show

      end

      # GET /xmt/templates/new
      def new
        @script = Xmt::Asset::Script.new(slug: @site.theme || @site.slug, parent_id: params[:id], file_con: "")
      end

      # GET /xmt/templates/1/edit
      def edit
        @script = Xmt::Asset::Script.all(@site.theme || @site.slug).detect {|t| t.id.to_s == params[:id]}
      end


      # POST /xmt/templates
      # POST /xmt/templates.json
      def create
        @script = Xmt::Asset::Script.new(style_params)
        respond_to do |format|
          if @script.sive
            format.html {redirect_to xmt_asset_scripts_url(site_id: @site.id), notice: '模板添加成功.'}
            format.json {render :show, status: :created, location: @script}
          else
            format.html {render :new}
            format.json {render json: @script.errors, status: :unprocessable_entity}
          end
        end

        #redirect_to mgr_templates_url(site_id:@site.id), sms: 'Snippet was successfully update.'
      end

      # PATCH/PUT /xmt/templates/1
      # PATCH/PUT /xmt/templates/1.json
      def update
        @script = Xmt::Asset::Script.new(style_params)
        respond_to do |format|
          if @script.sive
            format.html {redirect_to xmt_asset_scripts_url(site_id: @site.id), notice: '模板修改成功.'}
            format.json {render :show, status: :created, location: @script}
          else
            format.html {render :new}
            format.json {render json: @script.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/templates/1
      # DELETE /xmt/templates/1.json
      def destroy
        @script.delete
        redirect_to xmt_asset_styles_url(site_id: @site.id), notice: '模板删除成功.'
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_script
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
        @script = Xmt::Asset::Script.all(@site.theme || @site.slug).detect {|t| t.id.to_s == params[:id]}
      end

      def set_site
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def style_params
        params.require(:xmt_asset_script).permit!
      end
    end
  end
end