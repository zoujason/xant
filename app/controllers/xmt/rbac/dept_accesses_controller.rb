module Xmt
  module Rbac
    class DeptAccessesController < AdminController
  before_action :set_xmt_mgr_dept_access, only: [:show, :edit, :update, :destroy]

  # GET /xmt_mgr/dept_accesses
  # GET /xmt_mgr/dept_accesses.json
  def index
    @depts = Xmt::Staff::Dept.all
    @roles = Xmt::Rbac::Role.all
    @role = Xmt::Rbac::Role.where(id: params[:role_id]).first unless params[:role_id].blank?
    @role ||= @roles.first
  end

  # GET /xmt_mgr/dept_accesses/1
  # GET /xmt_mgr/dept_accesses/1.json
  def show
  end

  # GET /xmt_mgr/dept_accesses/new
  def new

  end

  # GET /xmt_mgr/dept_accesses/1/edit
  def edit
  end

  # POST /xmt_mgr/dept_accesses
  # POST /xmt_mgr/dept_accesses.json
  def create
    params.require(:permissions).permit!
    params[:permissions].each do |k,v|
      perm = Permission.find_or_initialize_by(aropermitable_id: BSON::ObjectId(v[:aropermitable_id]),  acopermitable_id: BSON::ObjectId(v[:acopermitable_id]))
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
        format.html { redirect_to xmt_rbac_dept_accesses_path(dept_id:params[:dept_id]), notice: '配置成功' }
        format.json { render :show, status: :created, location: @mgr_menu_access }
      else
        format.html { render :new }
        format.json { render json: @mgr_menu_access.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /xmt_mgr/dept_accesses/1
  # PATCH/PUT /xmt_mgr/dept_accesses/1.json
  def update
    respond_to do |format|
      if @xmt_mgr_dept_access.update(xmt_mgr_dept_access_params)
        format.html { redirect_to @xmt_mgr_dept_access, notice: 'Dept access was successfully updated.' }
        format.json { render :show, status: :ok, location: @xmt_mgr_dept_access }
      else
        format.html { render :edit }
        format.json { render json: @xmt_mgr_dept_access.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /xmt_mgr/dept_accesses/1
  # DELETE /xmt_mgr/dept_accesses/1.json
  def destroy
    @xmt_mgr_dept_access.destroy
    respond_to do |format|
      format.html { redirect_to xmt_mgr_dept_accesses_url, notice: 'Dept access was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_xmt_mgr_dept_access
      @xmt_mgr_dept_access = XmtMgr::DeptAccess.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def xmt_mgr_dept_access_params
      params.fetch(:xmt_mgr_dept_access, {})
    end
end
  end
end

