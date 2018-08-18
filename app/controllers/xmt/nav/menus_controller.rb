module Xmt
  module Nav
    class MenusController < AdminController
      before_action :set_menu, only: [:show, :edit, :update, :destroy]

      # GET /xmt/menus
      # GET /xmt/menus.json
      def index
        @menus = Xmt::Nav::Menu.all
      end

      # GET /xmt/menus/1
      # GET /xmt/menus/1.json
      def show
      end

      # GET /xmt/menus/new
      def new
        @menu = Xmt::Nav::Menu.new
      end

      # GET /xmt/menus/1/edit
      def edit
      end

      # POST /xmt/menus
      # POST /xmt/menus.json
      def create
        @menu = Xmt::Nav::Menu.new(menu_params)

        respond_to do |format|
          if @menu.save
            format.html {redirect_to xmt_nav_menu_path(@menu), notice: '菜单创建成功.'}
            format.json {render :show, status: :created, location: @menu}
          else
            format.html {render :new}
            format.json {render json: @menu.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/menus/1
      # PATCH/PUT /xmt/menus/1.json
      def update
        respond_to do |format|
          if @menu.update(menu_params)
            format.html {redirect_to xmt_nav_menu_path(@menu), notice: '菜单更新成功.'}
            format.json {render :show, status: :ok, location: @menu}
          else
            format.html {render :edit}
            format.json {render json: @menu.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/menus/1
      # DELETE /xmt/menus/1.json
      def destroy
        @menu.destroy
        respond_to do |format|
          format.html {redirect_to xmt_nav_menus_url, notice: '菜单删除成功.'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_menu
        @menu = Xmt::Nav::Menu.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def menu_params
        params.require(:xmt_nav_menu).permit!
      end
    end
  end
end