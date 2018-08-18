module Xmt
  module Press
    class SnippetsController < AdminController
      before_action :set_snippet, only: [:show, :edit, :update, :destroy]
      before_action :set_site
      # GET /xmt/snippets
      # GET /xmt/snippets.json
      def index
        @snippets = Snippet.all.page(params[:page])
        unless params[:key].blank?
          key = /.*#{params[:key]}.*/
          @snippets = @snippets.where(title: key).page(params[:page])
        end
      end

      # GET /xmt/snippets/1
      # GET /xmt/snippets/1.json
      def show
      end

      # GET /xmt/snippets/new
      def new
        @snippet = Snippet.new
      end

      # GET /xmt/snippets/1/edit
      def edit
      end

      # POST /xmt/snippets
      # POST /xmt/snippets.json
      def create
        @snippet = Snippet.new(snippet_params)

        respond_to do |format|
          if @snippet.save
            format.html { redirect_to xmt_press_snippets_url, notice: '添加成功.' }
            format.json { render :show, status: :created, location: @snippet }
          else
            format.html { render :new }
            format.json { render json: @snippet.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /xmt/snippets/1
      # PATCH/PUT /xmt/snippets/1.json
      def update
        respond_to do |format|
          if @snippet.update(snippet_params)
            format.html { redirect_to xmt_press_snippets_url, notice: '修改成功.' }
            format.json { render :show, status: :ok, location: @snippet }
          else
            format.html { render :edit }
            format.json { render json: @snippet.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /xmt/snippets/1
      # DELETE /xmt/snippets/1.json
      def destroy
        @snippet.destroy
        respond_to do |format|
          format.html { redirect_to xmt_press_snippets_url, notice: '删除成功.' }
          format.json { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_snippet
        @snippet = Snippet.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def snippet_params
        params.require(:xmt_press_snippet).permit(:title,:cont,:sign)
      end

      def set_site
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
      end

    end
  end

end
