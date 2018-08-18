module Xmt
  module Press
    class TemplatesController < AdminController
      before_action :set_template, only: [:edit, :destroy]
      before_action :set_site
      # GET /xmt/templates
      # GET /xmt/templates.json
      def index
        @templates = Xmt::Press::Template.all(@site.theme || @site.slug)
      end

      # GET /xmt/templates/1
      # GET /xmt/templates/1.json
      def show

      end

      # GET /xmt/templates/new
      def new
        @template = Xmt::Press::Template.new(slug: @site.theme || @site.slug, parent_id: params[:id], file_con: "")
      end

      # GET /xmt/templates/1/edit
      def edit
        @template = Xmt::Press::Template.all(@site.theme || @site.slug).detect {|t| t.id.to_s == params[:id]}
      end


      # POST /xmt/templates
      # POST /xmt/templates.json
      def create
        @template = Xmt::Press::Template.new(template_params)
        respond_to do |format|
          if @template.sive
            format.html {redirect_to xmt_press_templates_url(site_id: @site.id), notice: '模板添加成功.'}
            format.json {render :show, status: :created, location: @template}
          else
            format.html {render :new}
            format.json {render json: @template.errors, status: :unprocessable_entity}
          end
        end

        #redirect_to mgr_templates_url(site_id:@site.id), sms: 'Snippet was successfully update.'
      end

      # PATCH/PUT /xmt/templates/1
      # PATCH/PUT /xmt/templates/1.json
      def update
        @template = Xmt::Press::Template.new(template_params)
        respond_to do |format|
          if @template.sive
            format.html {redirect_to xmt_press_templates_url(site_id: @site.id), notice: '模板修改成功.'}
            format.json {render :show, status: :created, location: @template}
          else
            format.html {render :new}
            format.json {render json: @template.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/templates/1
      # DELETE /xmt/templates/1.json
      def destroy
        @template.delete
        redirect_to xmt_press_templates_url(site_id: @site.id), notice: '模板删除成功.'
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_template
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
        @template = Xmt::Press::Template.all(@site.theme || @site.slug).detect {|t| t.id.to_s == params[:id]}
      end

      def set_site
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def template_params
        params.require(:xmt_press_template).permit!
      end
    end
  end
end