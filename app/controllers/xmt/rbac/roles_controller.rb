module Xmt
  module Rbac
    class RolesController < AdminController
      before_action :set_role, only: [:show, :edit, :update, :destroy]

      # GET /xmt/roles
      # GET /xmt/roles.json
      def index
        @roles = Xmt::Rbac::Role.all.page(params[:page])
      end

      # GET /xmt/roles/1
      # GET /xmt/roles/1.json
      def show
      end

      # GET /xmt/roles/new
      def new
        @role = Xmt::Rbac::Role.new
      end

      # GET /xmt/roles/1/edit
      def edit
      end

      # POST /xmt/roles
      # POST /xmt/roles.json
      def create
        @role = Xmt::Rbac::Role.new(role_params)

        respond_to do |format|
          if @role.save
            format.html {redirect_to xmt_rbac_roles_url, notice: '角色创建成功.'}
            format.json {render :show, status: :created, location: @role}
          else
            format.html {render :new}
            format.json {render json: @role.errors, status: :unprocessable_entity}

          end
        end
      end

      # PATCH/PUT /xmt/roles/1
      # PATCH/PUT /xmt/roles/1.json
      def update
        respond_to do |format|
          if @role.update(role_params)
            format.html {redirect_to xmt_rbac_roles_url, notice: '角色编辑成功.'}
            format.json {render :show, status: :ok, location: @role}
          else
            format.html {render :edit}
            format.json {render json: @role.errors, status: :unprocessable_entity}

          end
        end
      end

      # DELETE /roles/1
      # DELETE /roles/1.json
      def destroy
        @role.destroy
        respond_to do |format|
          format.html {redirect_to xmt_rbac_roles_url, notice: '角色删除成功.'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_role
        @role = Xmt::Rbac::Role.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def role_params
        params.require(:xmt_rbac_role).permit!

      end
    end
  end
end
