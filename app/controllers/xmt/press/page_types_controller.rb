module Xmt
  module Press
    class PageTypesController < AdminController
      before_action :set_page_type, only: [:show, :edit, :update, :destroy]
      before_action :set_site_and_channel
      # GET /xmt/press/rdf_types
      # GET /xmt/press/rdf_types.json
      def index
        @page_types = Xmt::Press::PageType.all
      end

      # GET /xmt/press/rdf_types/1
      # GET /xmt/press/rdf_types/1.json
      def show
      end

      # GET /xmt/press/rdf_types/new
      def new
        @page_type = Xmt::Press::PageType.new
      end

      # GET /xmt/press/rdf_types/1/edit
      def edit
      end

      # POST /xmt/press/rdf_types
      # POST /xmt/press/rdf_types.json
      def create
        @page_type = Xmt::Press::PageType.new(page_type_params)
        respond_to do |format|
          if @page_type.save
            format.html {redirect_to xmt_press_page_types_url, notice: '资源创建成功.'}
            format.json {render :show, status: :created, location: @page_type}
          else
            format.html {render :new}
            format.json {render json: @page_type.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/press/rdf_types/1
      # PATCH/PUT /xmt/press/rdf_types/1.json
      def update
        respond_to do |format|
          @page_type.page_attrs = nil
          if @page_type.update(page_type_params)
            format.html {redirect_to xmt_press_page_types_url, notice: '资源修改成功'}
            format.json {render :show, status: :ok, location: @page_type}
          else
            format.html {render :edit}
            format.json {render json: @page_type.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/press/rdf_types/1
      # DELETE /xmt/press/rdf_types/1.json
      def destroy
        if @page_type.page.count == 0
          @page_type.destroy
          respond_to do |format|
            format.html {redirect_to xmt_press_page_types_url, notice: '资源删除成功'}
            format.json {head :no_content}
          end
        else
          redirect_to xmt_press_page_types_url, notice: '存在资源绑定，暂不能删除！'
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_page_type
        @page_type = Xmt::Press::PageType.find(params[:id])

      end

      def set_site_and_channel
        @site =  params[:site_id].blank? ? Site.first : Site.where(id: params[:site_id]).first
      end
      # Never trust parameters from the scary internet, only allow the white list through.
      def page_type_params
        params.require(:xmt_press_page_type).permit!
      end
    end
  end
end
