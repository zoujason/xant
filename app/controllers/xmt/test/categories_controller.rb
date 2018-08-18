module Xmt
  module Test
    class CategoriesController <  AdminController
      before_action :set_xmt_test_category, only: [:show, :edit, :update, :destroy]

      # GET /test/categories
      # GET /test/categories.json
      def index
        opts= {}
        opts[:title] =/.*#{params[:key]}.*/ unless params[:key].blank?
        @categories = Xmt::Test::Category.where(opts).order(depth: :asc).page(params[:page]).per(10)
      end

      # GET /test/categories/1
      # GET /test/categories/1.json
      def show
      end

      # GET /test/categories/new
      def new
        @category = Xmt::Test::Category.new
      end

      # GET /test/categories/1/edit
      def edit
      end

      # POST /test/categories
      # POST /test/categories.json
      def create
        @category = Xmt::Test::Category.new(category_params)

        respond_to do |format|
          if @category.save
            format.html { redirect_to xmt_test_categories_url, notice: '添加成功.' }
            format.json { render :show, status: :created, location: @category }
          else
            format.html { render :new }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /test/categories/1
      # PATCH/PUT /test/categories/1.json
      def update
        respond_to do |format|
          if @category.update(category_params)
            format.html { redirect_to xmt_test_categories_url, notice: '编辑成功.' }
            format.json { render :show, status: :ok, location: @category }
          else
            format.html { render :edit }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /test/categories/1
      # DELETE /test/categories/1.json
      def destroy
        @category.destroy
        respond_to do |format|
          format.html { redirect_to xmt_test_categories_url, notice: '删除成功.' }
          format.json { head :no_content }
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_xmt_test_category
          @category = Xmt::Test::Category.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def category_params
          params.require(:xmt_test_category).permit!
        end
    end
  end
end

