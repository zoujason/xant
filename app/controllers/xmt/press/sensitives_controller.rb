module Xmt
  module Press
    class SensitivesController < AdminController
      before_action :set_sensitive, only: [:show, :edit, :update, :destroy]

      # GET /xmt/press/sensitives
      # GET /xmt/press/sensitives.json
      def index
        @sensitives = Sensitive.all.page(params[:page])
      end

      # GET /xmt/press/sensitives/1
      # GET /xmt/press/sensitives/1.json
      def show
      end

      # GET /xmt/press/sensitives/new
      def new
        @sensitive = Sensitive.new
      end

      # GET /xmt/press/sensitives/1/edit
      def edit
      end

      # POST /xmt/press/sensitives
      # POST /xmt/press/sensitives.json
      def create
        @sensitive = Sensitive.new(sensitive_params)

        respond_to do |format|
          if @sensitive.save
            format.html { redirect_to xmt_press_sensitives_path, notice: '敏感词添加成功.' }
            format.json { render :show, status: :created, location: @sensitive }
          else
            format.html { render :new }
            format.json { render json: @sensitive.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /xmt/press/sensitives/1
      # PATCH/PUT /xmt/press/sensitives/1.json
      def update
        respond_to do |format|
          if @sensitive.update(sensitive_params)
            format.html { redirect_to xmt_press_sensitives_path, notice: '敏感词修改成功.' }
            format.json { render :show, status: :ok, location: @sensitive }
          else
            format.html { render :edit }
            format.json { render json: @sensitive.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /xmt/press/sensitives/1
      # DELETE /xmt/press/sensitives/1.json
      def destroy
        @sensitive.destroy
        respond_to do |format|
          format.html { redirect_to xmt_press_sensitives_path, notice: '敏感词删除成功' }
          format.json { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_sensitive
        @sensitive = Sensitive.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def sensitive_params
        params.require(:xmt_press_sensitive).permit!
      end
    end
  end
end

