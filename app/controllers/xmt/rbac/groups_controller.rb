module Xmt
  module Rbac
    class GroupsController < AdminController
      before_action :set_group, only: [:show, :edit, :update, :destroy]

      # GET /xmt/groups
      # GET /xmt/groups.json
      def index
        @groups = Xmt::Rbac::Group.all.page(params[:page])
      end

      # GET /xmt/groups/1
      # GET /xmt/groups/1.json
      def show
      end

      # GET /xmt/groups/new
      def new
        @group = Xmt::Rbac::Group.new
      end

      # GET /xmt/groups/1/edit
      def edit
      end

      # POST /xmt/groups
      # POST /xmt/groups.json
      def create
        @group = Xmt::Rbac::Group.new(group_params)

        respond_to do |format|
          if @group.save
            format.html {redirect_to xmt_rbac_groups_path(@group), notice: '用户组创建成功.'}
            format.json {render :show, status: :created, location: @group}
          else
            format.html {render :new}
            format.json {render json: @group.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/groups/1
      # PATCH/PUT /xmt/groups/1.json
      def update
        respond_to do |format|
          if @group.update(group_params)
            format.html {redirect_to xmt_rbac_groups_path(@group), notice: '用户组更新成功.'}
            format.json {render :show, status: :ok, location: @group}
          else
            format.html {render :edit}
            format.json {render json: @group.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/groups/1
      # DELETE /xmt/groups/1.json
      def destroy
        @group.destroy
        respond_to do |format|
          format.html {redirect_to xmt_rbac_groups_url, notice: '用户组删除成功.'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_group
        @group = Xmt::Rbac::Group.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def group_params
        params.require(:xmt_rbac_group).permit(:name)
      end
    end
  end
end
