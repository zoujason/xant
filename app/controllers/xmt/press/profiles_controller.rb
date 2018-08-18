module Xmt
  module Press
    class ProfilesController < AdminController
      before_action :set_profile, only: [:show, :edit, :update, :destroy]
      before_action :set_site
      # GET /xmt/profiles
      # GET /xmt/profiles.json
      def index
        @profiles = Xmt::Press::Profile.where(parent_id: @site.try(:id)).page(params[:page]).per(10)
      end

      # GET /xmt/profiles/1
      # GET /xmt/profiles/1.json
      def show
      end

      # GET /xmt/profiles/new
      def new
        @profile = Xmt::Press::Profile.new
      end

      # GET /xmt/profiles/1/edit
      def edit
      end

      # POST /xmt/profiles
      # POST /xmt/profiles.json
      def create
        @profile = Xmt::Press::Profile.new(profile_params)

        respond_to do |format|
          if @profile.save
            format.html {redirect_to xmt_press_profiles_url(site_id: @site.id), notice: '留言板块创建成功.'}
            format.json {render :show, status: :created, location: @profile}
          else
            format.html {render :new}
            format.json {render json: @profile.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/profiles/1
      # PATCH/PUT /xmt/profiles/1.json
      def update
        respond_to do |format|
          if @profile.update(profile_params)
            format.html {redirect_to xmt_press_profiles_url(site_id: @site.id), notice: '留言板块修改成功.'}
            format.json {render :show, status: :ok, location: @profile}
          else
            format.html {render :edit}
            format.json {render json: @profile.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/profiles/1
      # DELETE /xmt/profiles/1.json
      def destroy
        @profile.destroy
        respond_to do |format|
          format.html {redirect_to xmt_press_profiles_url(site_id: @site.id), notice: '留言板块删除成功.'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_profile
        @profile = Xmt::Press::Profile.find(params[:id])
      end

      def set_site
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def profile_params
        params.require(:xmt_press_profile).permit!
      end
    end
  end
end

