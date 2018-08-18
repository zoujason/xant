module Xmt
  module Staff
    class MembersController < AdminController
      before_action :set_member, only: [:show, :edit, :update, :destroy]
      before_action :set_site
      # GET /xmt/members
      # GET /xmt/members.json
      def index
        #@site ||= @sites.first
        @members = @site.members.page(params[:page])
      end

      # GET /xmt/members/1
      # GET /xmt/members/1.json
      def show
      end

      # GET /xmt/members/new
      def new
        @member = Xmt::Staff::Member.new
      end

      # GET /xmt/members/1/edit
      def edit
      end

      # POST /xmt/members
      # POST /xmt/members.json
      def create
        @member = Xmt::Staff::Member.new(member_params)

        respond_to do |format|
          if @member.save
            format.html {redirect_to xmt_staff_member_path(@member), notice: '用户创建成功.'}
            format.json {render :show, status: :created, location: @member}
          else
            format.html {render :new}
            format.json {render json: @member.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/members/1
      # PATCH/PUT /xmt/members/1.json
      def update
        respond_to do |format|
          if @member.update(member_params)
            format.html {redirect_to xmt_staff_member_path(@member), notice: '用户更新成功.'}
            format.json {render :show, status: :ok, location: @member}
          else
            format.html {render :edit}
            format.json {render json: @member.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/members/1
      # DELETE /xmt/members/1.json
      def destroy
        @member.destroy
        respond_to do |format|
          format.html {redirect_to xmt_staff_members_path, notice: '用户删除成功.'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_member
        @member = Xmt::Staff::Member.find(params[:id])
      end

      def set_site
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def member_params
        params.require(:xmt_staff_member).permit!
      end
    end
  end
end
