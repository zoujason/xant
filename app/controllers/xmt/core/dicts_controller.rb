module Xmt
  module Core
    class DictsController < AdminController
      before_action :set_dict, only: [:show, :edit, :update, :destroy]

      # GET /xmt/dicts
      # GET /xmt/dicts.json
      def index
        unless params[:sign].blank?
          @sign_dict = Xmt::Core::Dict.dicts(:"#{params[:sign]}")
          @dicts = Kaminari.paginate_array(@sign_dict, total_count: @sign_dict.size).page(params[:page]).per(15)
        else
          @dicts = Xmt::Core::Dict.all.page params[:page]
        end

      end

      # GET /xmt/dicts/1
      # GET /xmt/dicts/1.json
      def show

      end

      # GET /xmt/dicts/new
      def new

        @dict = Xmt::Core::Dict.new
      end

      # GET /xmt/dicts/1/edit
      def edit

      end

      # POST /xmt/dicts
      # POST /xmt/dicts.json
      def create
        @dict = Xmt::Core::Dict.new(dict_params)

        respond_to do |format|
          if @dict.save
            format.html {redirect_to xmt_core_dict_path(@dict), notice: '数据字典创建成功.'}
            format.json {render :show, status: :created, location: @dict}
          else
            format.html {render :new}
            format.json {render json: @dict.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/dicts/1
      # PATCH/PUT /xmt/dicts/1.json
      def update
        respond_to do |format|
          if @dict.update(dict_params)
            format.html {redirect_to xmt_core_dict_path(@dict), notice: '数据字典更新成功.'}
            format.json {render :show, status: :ok, location: @dict}
          else
            format.html {render :edit}
            format.json {render json: @dict.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/dicts/1
      # DELETE /xmt/dicts/1.json
      def destroy
        @dict.destroy
        respond_to do |format|
          format.html {redirect_to xmt_core_dicts_url, notice: '数据字典删除成功.'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_dict
        @dict = Xmt::Core::Dict.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def dict_params
        # params.fetch(:mgr_dict, {})
        params.require(:xmt_core_dict).permit!

      end
    end
  end
end
