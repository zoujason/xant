module Xmt
  module Staff
    class ManagersController < AdminController
      before_action :set_manager, only: [:show, :edit, :update, :destroy]

      # GET /xmt/managers
      # GET /xmt/managers.json
      def index
        opts = {}
        opts[:username] = /.*#{params[:username]}.*/ unless params[:username].blank?
        role_name = /.*#{params[:user_role]}.*/ unless params[:user_role].blank?
        @role = Xmt::Rbac::Role.where(name:role_name).first
        unless @role.blank?
          opts[:role_ids] = BSON::ObjectId(@role.id)
        end
        @managers = Xmt::Staff::Manager.where(opts).page(params[:page])
      end

      # GET /xmt/managers/1
      # GET /xmt/managers/1.json
      def show
      end

      # GET /xmt/managers/new
      def new
        @manager = Xmt::Staff::Manager.new
      end

      # GET /xmt/managers/1/edit
      def edit
      end

      # POST /xmt/managers
      # POST /xmt/managers.json
      def create
        @manager = Xmt::Staff::Manager.new(manager_params)

        respond_to do |format|
          if @manager.save
            format.html {redirect_to xmt_staff_manager_path(@manager), notice: '用户创建成功.'}
            format.json {render :show, status: :created, location: @manager}
          else
            format.html {render :new}
            format.json {render json: @manager.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/managers/1
      # PATCH/PUT /xmt/managers/1.json
      def update
        respond_to do |format|
          if @manager.update(manager_params)
            format.html {redirect_to xmt_staff_manager_path(@manager), notice: '用户更新成功.'}
            format.json {render :show, status: :ok, location: @manager}
          else
            format.html {render :edit}
            format.json {render json: @manager.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/managers/1
      # DELETE /xmt/managers/1.json
      def destroy
        @manager.destroy
        respond_to do |format|
          format.html {redirect_to xmt_staff_managers_path, notice: '用户删除成功.'}
          format.json {head :no_content}
        end
      end

      def search_user_role

      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_manager
        @manager = Xmt::Staff::Manager.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def manager_params
        params.require(:xmt_staff_manager).permit!
      end
    end
  end
end
