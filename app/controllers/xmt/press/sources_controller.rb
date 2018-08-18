module Xmt
  module Press
    class SourcesController < AdminController
      before_action :set_xmt_press_source, only: [:show, :edit, :update, :destroy]
      before_action :set_site_and_channel
      # GET /xmt/press/sources
      # GET /xmt/press/sources.json
      def index
        @sites = Xmt::Press::Site.all.to_a
        opts = {
            parent_ids: @site.id,
            status: params[:status]
        }.delete_if {|k, v| v.blank?}
        opts[:parent_id] = params[:channel_id] unless params[:channel_id].blank?
        opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?
        @xmt_press_sources = Xmt::Press::Source.includes(:channel).where(opts).order(id: :desc).page(params[:page])
        @xmt_press_sources.order(rcmd_level: :desc) unless params[:rcmd].blank?
        @xmt_press_sources.order(headline_level: :desc) unless params[:headline].blank?
      end

      # GET /xmt/press/sources/1
      # GET /xmt/press/sources/1.json
      def show
      end

      # GET /xmt/press/sources/new
      def new
        @xmt_press_source = Xmt::Press::Source.new

      end

      # GET /xmt/press/sources/1/edit
      def edit
      end

      # POST /xmt/press/sources
      # POST /xmt/press/sources.json
      def create
        @xmt_press_source = Xmt::Press::Source.new(xmt_press_source_params)
        respond_to do |format|
          if @xmt_press_source.save
            format.html {redirect_to xmt_press_sources_url(channel_id: xmt_press_source_params[:parent_id]), notice: 'Source was successfully created.'}
            format.json {render :show, status: :created, location: @xmt_press_source}
          else
            format.html {render :new}
            format.json {render json: @xmt_press_source.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/press/sources/1
      # PATCH/PUT /xmt/press/sources/1.json
      def update
        @xmt_press_source.rdf_attr_values=nil
        respond_to do |format|
          if @xmt_press_source.update(xmt_press_source_params)
            format.html {redirect_to xmt_press_sources_url(channel_id: xmt_press_source_params[:parent_id]), notice: 'Source was successfully updated.'}
            format.json {render :show, status: :ok, location: @xmt_press_source}
          else
            format.html {render :edit}
            format.json {render json: @xmt_press_source.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/press/sources/1
      # DELETE /xmt/press/sources/1.json
      def destroy
        @xmt_press_source.destroy
        respond_to do |format|
          format.html {redirect_to xmt_press_sources_url(channel_id: params[:channel_id]), notice: 'Source was successfully destroyed.'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_xmt_press_source
        @xmt_press_source = Xmt::Press::Source.find(params[:id])
      end

      def set_site_and_channel
        @site = Xmt::Press::Site.first # params[:site_id].blank? ? Site.first : Site.where(id: params[:site_id]).first
        @channel = params[:channel_id].blank? ? (@site.channels.first) : Xmt::Press::Channel.where(id: params[:channel_id]).first
        @comments =params[:id].blank? ? {} : Xmt::Press::Comment.where(page_id: params[:id]).page(params[:page])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def xmt_press_source_params
        params.require(:xmt_press_source).permit!
      end
    end
  end
end

