module Xmt
  class AddonsController < AdminController
    before_action :set_addon, only: [:show, :edit, :update, :destroy]

    # GET /xmt/addons
    # GET /xmt/addons.json
    def index
      @apps = Addon.all
    end

    # GET /xmt/addons/1
    # GET /xmt/addons/1.json
    def show
    end

    # GET /xmt/addons/new
    def new
      @addon = Addon.new
    end

    # GET /xmt/addons/1/edit
    def edit
      @addon.setup
      @addon.save(isinstall: 1)
      respond_to do |format|
        format.html { redirect_to xmt_addons_url, notice: '安装成功.' }
        format.json { head :no_content }
      end
    end

    # POST /xmt/addons
    # POST /xmt/addons.json
    def create
    end

    # PATCH/PUT /xmt/addons/1
    # PATCH/PUT /xmt/addons/1.json
    def update
    end

    # DELETE /xmt/addons/1
    # DELETE /xmt/addons/1.json
    def destroy
      @addon.drop
      @addon.save(isinstall: 0)
      respond_to do |format|
        format.html { redirect_to xmt_addons_url, notice: '卸载成功.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_addon
      @addon = Addon.all.find {|a| a.name == params[:id]}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def addon_params
      params.require(:xmt_addon).permit!
    end
  end
end
