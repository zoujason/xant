module Xmt
  module Press
    class KendouisController < AdminController
      before_action :set_xmt_press_kendoui, only: [:show, :edit, :update, :destroy]

      # GET /xmt/press/kendouis
      # GET /xmt/press/kendouis.json
      def index
        # @xmt_press_kendouis = Xmt::Press::Kendoui.all
      end

      def index_list
        p "3333:#{params[:kind]}"
        @articles = Xmt::Press::Article.all
        if !@articles.blank?
          # headers['Access-Control-Allow-Origin'] = '*'
          render json: @articles.map {|article| {title: article.title, picture: article.avatar_url(), url: article.linkpage.blank? ? "http://wdlczw.hljgov.com/pages/#{article.id}" : article.linkpage}}
        else
          render json: ''
        end
      end

      # GET /xmt/press/kendouis/1
      # GET /xmt/press/kendouis/1.json
      def show
      end

      # GET /xmt/press/kendouis/new
      def new
        @xmt_press_kendoui = Xmt::Press::Kendoui.new
      end

      # GET /xmt/press/kendouis/1/edit
      def edit
      end

      # POST /xmt/press/kendouis
      # POST /xmt/press/kendouis.json
      def create
        @xmt_press_kendoui = Xmt::Press::Kendoui.new(xmt_press_kendoui_params)

        respond_to do |format|
          if @xmt_press_kendoui.save
            format.html {redirect_to @xmt_press_kendoui, notice: 'Kendoui was successfully created.'}
            format.json {render :show, status: :created, location: @xmt_press_kendoui}
          else
            format.html {render :new}
            format.json {render json: @xmt_press_kendoui.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/press/kendouis/1
      # PATCH/PUT /xmt/press/kendouis/1.json
      def update
        respond_to do |format|
          if @xmt_press_kendoui.update(xmt_press_kendoui_params)
            format.html {redirect_to @xmt_press_kendoui, notice: 'Kendoui was successfully updated.'}
            format.json {render :show, status: :ok, location: @xmt_press_kendoui}
          else
            format.html {render :edit}
            format.json {render json: @xmt_press_kendoui.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/press/kendouis/1
      # DELETE /xmt/press/kendouis/1.json
      def destroy
        @xmt_press_kendoui.destroy
        respond_to do |format|
          format.html {redirect_to xmt_press_kendouis_url, notice: 'Kendoui was successfully destroyed.'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_xmt_press_kendoui
        @xmt_press_kendoui = Xmt::Press::Kendoui.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def xmt_press_kendoui_params
        params.fetch(:xmt_press_kendoui, {})
      end
    end
  end
end
