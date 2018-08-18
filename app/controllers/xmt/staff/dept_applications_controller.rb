module Xmt
  module Staff
    class DeptApplicationsController < AdminController
      before_action :set_dept, only: [:show, :edit, :update, :destroy]

      # GET /xmt/staff/dept_applications
      # GET /xmt/staff/dept_applications.json
      def index

        @depts = Xmt::Staff::DeptApplication.where(depth: 1)
        @dept =  params[:dept_id].blank? ?  Xmt::Staff::DeptApplication.first : Xmt::Staff::DeptApplication.find(params[:dept_id])

      end

      # GET /xmt/staff/dept_applications/1
      # GET /xmt/staff/dept_applications/1.json
      def show
      end

      # GET /xmt/staff/dept_applications/new
      def new
        @dept = Xmt::Staff::DeptApplication.new
      end

      # GET /xmt/staff/dept_applications/1/edit
      def edit
      end

      # POST /xmt/staff/dept_applications
      # POST /xmt/staff/dept_applications.json
      def create
        @dept = Xmt::Staff::DeptApplication.new(dept_application_params)

        respond_to do |format|
          if @dept.save
            format.html { redirect_to xmt_staff_dept_applications_url, notice: '添加成功.' }
            format.json { render :show, status: :created, location:@dept  }
          else
            format.html { render :new }
            format.json { render json: @dept.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /xmt/staff/dept_applications/1
      # PATCH/PUT /xmt/staff/dept_applications/1.json
      def update
        respond_to do |format|
          if  @dept.update(dept_application_params)
            format.html { redirect_to  xmt_staff_dept_applications_url, notice: '编辑成功.' }
            format.json { render :show, status: :ok, location:  @dept }
          else
            format.html { render :edit }
            format.json { render json: @dept .errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /xmt/staff/dept_applications/1
      # DELETE /xmt/staff/dept_applications/1.json
      def destroy
        @dept.destroy
        respond_to do |format|
          format.html { redirect_to xmt_staff_dept_applications_url, notice: '删除成功.' }
          format.json { head :no_content }
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_dept
          @dept = Xmt::Staff::DeptApplication.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def dept_application_params
          params.require(:xmt_staff_dept_application).permit!
        end
    end
  end
end

