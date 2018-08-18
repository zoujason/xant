module Xmt
  module Rbac
    class SiteAccessesController < AdminController
      #before_action :set_mgr_site_access, only: [:show, :edit, :update, :destroy]

      # GET /xmt/site_accesses
      # GET /xmt/site_accesses.json
      def index
        @sites = Xmt::Press::Site.all
        @site = Xmt::Press::Site.where(id: params[:site_id]).first unless params[:site_id].blank?
        @site ||= @sites.first
        @roles = Xmt::Rbac::Role.all
        @role = Xmt::Rbac::Role.where(id: params[:role_id]).first unless params[:role_id].blank?
        @role ||= @roles.first
      end

      # GET /xmt/site_accesses/1
      # GET /xmt/site_accesses/1.json
      def show
      end

      # GET /xmt/site_accesses/new
      def new
        @mgr_site_access = Xmt::SiteAccess.new
      end

      # GET /xmt/site_accesses/1/edit
      def edit
      end

      # POST /xmt/site_accesses
      # POST /xmt/site_accesses.json
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
            format.html {redirect_to xmt_rbac_site_accesses_path(site_id: params[:site_id]), notice: '添加成功.'}
            format.json {render :show, status: :created, location: @mgr_site_access}
          else
            format.html {render :new}
            format.json {render json: @mgr_menu_access.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/site_accesses/1
      # PATCH/PUT /xmt/site_accesses/1.json
      def update
        respond_to do |format|
          if @mgr_site_access.update(mgr_site_access_params)
            format.html {redirect_to @mgr_site_access, notice: '修改成功.'}
            format.json {render :show, status: :ok, location: @mgr_site_access}
          else
            format.html {render :edit}
            format.json {render json: @mgr_site_access.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/site_accesses/1
      # DELETE /xmt/site_accesses/1.json
      def destroy
        @mgr_site_access.destroy
        respond_to do |format|
          format.html {redirect_to xmt_rbac_site_accesses_url, notice: '删除成功.'}
          format.json {head :no_content}
        end
      end

    end
  end
end
