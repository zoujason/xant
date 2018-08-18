module Xmt
  module Rbac
    class MenuAccessesController < AdminController

      # GET /xmt/menu_accesses
      # GET /xmt/menu_accesses.json
      def index
        @menus = Xmt::Nav::Menu.all
        @menu = Xmt::Nav::Menu.where(id: params[:menu_id]).first unless params[:menu_id].blank?
        @menu ||= @menus.first
        @roles = Xmt::Rbac::Role.all
        @role = Xmt::Rbac::Role.where(id: params[:role_id]).first unless params[:role_id].blank?
        @role ||= @roles.first
      end

      # GET /xmt/menu_accesses/1
      # GET /xmt/menu_accesses/1.json
      def show
      end

      # GET /xmt/menu_accesses/new
      def new

      end

      # GET /xmt/menu_accesses/1/edit
      def edit
      end

      # POST /xmt/menu_accesses
      # POST /xmt/menu_accesses.json
      def create
        params.require(:permissions).permit!
        params[:permissions].each do |k, v|
          perm = Xmt::Rbac::Permission.find_or_initialize_by(aropermitable_id: BSON::ObjectId(v[:aropermitable_id]), acopermitable_id: BSON::ObjectId(v[:acopermitable_id]))
          perm.aropermitable_type = v[:aropermitable_type]
          perm.acopermitable_type = v[:acopermitable_type]
          perm.privileges = []
          v[:privileges].each do |priv|
            perm.privileges.build(priv) if priv[:permit] == 'true'
          end
          if perm.privileges.size > 0
            perm.save
          else
            perm.destroy unless perm.new_record?
          end
        end
        PermissionMgr.instance.load
        respond_to do |format|
          if true
            format.html {redirect_to xmt_rbac_menu_accesses_path(menu_id: params[:menu_id]), notice: '菜单权限设置成功.'}
            format.json {render :show, status: :created, location: @mgr_menu_access}
          else
            format.html {render :new}
            format.json {render json: @mgr_menu_access.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/menu_accesses/1
      # PATCH/PUT /xmt/menu_accesses/1.json
      def update
        respond_to do |format|
          if @mgr_menu_access.update(menu_accesses_params)
            format.html {redirect_to @mgr_menu_access, notice: '菜单权限设置更新成功'}
            format.json {render :show, status: :ok, location: @mgr_menu_access}
          else
            format.html {render :edit}
            format.json {render json: @mgr_menu_access.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/menu_accesses/1
      # DELETE /xmt/menu_accesses/1.json
      def destroy
        @mgr_menu_access.destroy
        respond_to do |format|
          format.html {redirect_to xmt_rbac_menu_accesses_url, notice: 'Menu access was successfully destroyed.'}
          format.json {head :no_content}
        end
      end

      def menu_accesses_params
        params.require(:xmt_rbac_menu_access).permit!
      end
    end
  end
end
