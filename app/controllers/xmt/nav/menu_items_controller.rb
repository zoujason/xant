module Xmt
  module Nav
    class MenuItemsController < AdminController
      before_action :set_menu_item, only: [:show, :edit, :update, :destroy]
      before_action :set_menu

      # GET /xmt/menu_items
      # GET /xmt/menu_items.json
      def index
        @menu ||= @menus.first
        @menu_table = MenuItemTreeBuilder.new(@menu)
        @menu_table.build
      end

      # GET /xmt/menu_items/1
      # GET /xmt/menu_items/1.json
      def show
      end

      # GET /xmt/menu_items/new
      def new
        @menu_item = Xmt::Nav::MenuItem.new
      end

      # GET /xmt/menu_items/1/edit
      def edit
      end

      # POST /xmt/menu_items
      # POST /xmt/menu_items.json
      def create
        @menu_item = Xmt::Nav::MenuItem.new(menu_item_params)
        respond_to do |format|
          if @menu_item.save
            format.html {redirect_to xmt_nav_menu_item_path(@menu_item), notice: '菜单项创建成功.'}
            format.json {render :show, status: :created, location: @menu_item}
          else
            format.html {render :new}
            format.json {render json: @menu_item.errors, status: :unprocessable_entity}
          end
        end
      end


      # PATCH/PUT /xmt/menu_items/1
      # PATCH/PUT /xmt/menu_items/1.json
      def update
        respond_to do |format|
          if @menu_item.update(menu_item_params)
            format.html {redirect_to xmt_nav_menu_item_path(@menu_item), notice: '菜单项更新成功.'}
            format.json {render :show, status: :ok, location: @menu_item}
          else
            format.html {render :edit}
            format.json {render json: @menu_item.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/menu_items/1
      # DELETE /xmt/menu_items/1.json
      def destroy
        @menu_item.destroy
        respond_to do |format|
          format.html {redirect_to xmt_nav_menu_items_url(parent_id: @menu_item.root.id), notice: '菜单项删除成功.'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_menu
        @menus = Xmt::Nav::Menu.all
        @menu = params[:parent_id].blank? ? @menus.first : Xmt::Nav::Menu.find(params[:parent_id])
      end

      def set_menu_item
        @menu_item = Xmt::Nav::MenuItem.find(params[:id])
        @menu = @menu_item.root
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def menu_item_params
        params.require(:xmt_nav_menu_item).permit!
      end
    end
  end
end
