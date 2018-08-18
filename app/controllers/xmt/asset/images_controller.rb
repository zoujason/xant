module Xmt
  module Asset
    class ImagesController < AdminController
      include Xmt::Asset::AssetFilesHelper
      # before_action :set_xmt_static_image, only: [:show, :edit, :update, :destroy]
      before_action :set_site_and_dirname

      # GET /xmt/asset/images
      # GET /xmt/asset/images.json
      def index
        @sites = Xmt::Press::Site.all.to_a
        current_files = Xmt::Asset::Image.all(@current_path).sort_by do |i|
          [i.type,if i.type==:file
                    Time.parse(i.ctime).to_i
          end]
        end
        @flag = (@current_path!=@dirname)
        @images = Kaminari.paginate_array(current_files).page(params[:page]).per(10)
      end

      # GET /xmt/asset/images/1
      # GET /xmt/asset/images/1.json
      def show
      end

      # GET /xmt/asset/images/new
      def new

      end

      # GET /xmt/asset/images/1/edit
      def edit
      end

      # POST /xmt/asset/images
      # POST /xmt/asset/images.json
      def create
        result = Xmt::Asset::Image.create_file(params[:pictures],params[:file_path])
        respond_to do |format|
            format.html { redirect_to xmt_asset_images_url(site_id:@site.id,curp:params[:file_path]), notice: result }
            format.json { render :show, status: :created, location: article }
        end
      end

      # PATCH/PUT /xmt/asset/images/1
      # PATCH/PUT /xmt/asset/images/1.json
      def update
      end

      # DELETE /xmt/asset/images/1
      # DELETE /xmt/asset/images/1.json
      def destroy
        respond_to do |format|
          if Xmt::Asset::Image.delete(params[:filename])
            format.html {redirect_to xmt_asset_images_url(site_id:@site.id,curp:@current_path), notice: '图片删除成功.'}
            format.json {head :no_content}
          else
            format.html {redirect_to xmt_asset_images_url(site_id:@site.id,curp:@current_path), notice: '图片不存在.'}
            format.json {head :no_content}
          end
        end
      end

      def upload_zip_file
      end

      def zip_file_handle
        result = Xmt::Asset::Image.unzip_file(params[:file],params[:file_path])
        respond_to do |format|
          if result[:state]
            format.html {redirect_to xmt_asset_images_url(site_id:@site.id,curp:params[:file_path]), notice:result[:message]}
            format.json {head :no_content}
          else
            format.html {redirect_to upload_zip_file_xmt_asset_images_url(site_id:@site.id,curp:params[:file_path]), notice:result[:message]}
            format.json {head :no_content}
          end
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      # def set_xmt_static_image
      #   @xmt_static_image = Xmt::Static::Image.find(params[:id])
      # end

      # Never trust parameters from the scary internet, only allow the white list through.
      # def xmt_static_image_params
      #   params.fetch(:xmt_static_image, {})
      # end

      def set_site_and_dirname
        @site = params[:site_id].blank? ? Xmt::Press::Site.first : Xmt::Press::Site.where(id: params[:site_id]).first
        @dirname = "app/sites/#{@site.layout}/assets/images"
        @current_path = params[:curp].blank? ? "app/sites/#{@site.layout}/assets/images" : CGI::unescape(params[:curp])
      end


      def unzip_file(file,path)
        FileUtils.mkdir_p(path) unless File.exist?(path)
        Zip::File.open(file.path) do |zif_file|
          zif_file.each do |entry|
            if entry::ftype.to_s == 'file'
              if File::exists?(File.join(path, entry::name))
                File.delete(File.join(path, entry::name))
              end
            end
            zif_file.extract(entry,File.join(path, entry::name)){true}
          end
        end
      end


    end
  end
end

