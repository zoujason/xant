module Xmt
  module Staff
    class DeptsController < AdminController
      before_action :set_dept, only: [:show, :edit, :update, :destroy]

      # GET /xmt_mgr/depts
      # GET /xmt_mgr/depts.json
      def index
        @depts = Xmt::Staff::Dept.all.order(seq: :asc)
      end

      # GET /xmt_mgr/depts/1
      # GET /xmt_mgr/depts/1.json
      def show
      end

      # GET /xmt_mgr/depts/new
      def new
        @dept = Xmt::Staff::Dept.new
      end

      # GET /xmt_mgr/depts/1/edit
      def edit
      end

      # POST /xmt_mgr/depts
      # POST /xmt_mgr/depts.json
      def create
        @dept = Xmt::Staff::Dept.new(dept_params)
        respond_to do |format|
          if @dept.save
            format.html { redirect_to xmt_staff_depts_url, notice: '部门创建成功' }
            format.json { render :show, status: :created, location: @xmt_mgr_dept }
          else
            format.html { render :new }
            format.json { render json: @xmt_mgr_dept.errors, status: :unprocessable_entity }
          end
        end
      end
        # PATCH/PUT /xmt_mgr/depts/1
        # PATCH/PUT /xmt_mgr/depts/1.json
        def update
          respond_to do |format|
            if @dept.update(dept_params)
              format.html { redirect_to xmt_staff_depts_url, notice: '部门修改成功' }
              format.json { render :show, status: :ok, location: @xmt_mgr_dept }
            else
              format.html { render :edit }
              format.json { render json: @xmt_mgr_dept.errors, status: :unprocessable_entity }
            end
          end
        end

        # DELETE /xmt_mgr/depts/1
        # DELETE /xmt_mgr/depts/1.json
        def destroy
          @dept.destroy
          respond_to do |format|
            format.html { redirect_to xmt_staff_depts_url, notice: '部门删除成功' }
            format.json { head :no_content }
          end
        end

        private
        # Use callbacks to share common setup or constraints between actions.
        def set_dept
          @dept = Xmt::Staff::Dept.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def dept_params
          params.require(:xmt_staff_dept).permit!
        end

      end
    end
  end


