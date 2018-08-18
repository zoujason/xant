module Xmt
  module Faq
    class TipsController < AdminController
      before_action :set_message, only: [:show, :edit, :update, :destroy]
      before_action :set_site
      # GET /xmt_mgr/messages
      # GET /xmt_mgr/messages.json
      def index
        opts = {}
        opts[:site_id] = params[:site_id].blank? ? @site.id : params[:site_id]
        opts[:jb_name] = /.*#{params[:key]}.*/ unless params[:key].blank?
        opts[:checked] = params[:checked] unless params[:checked].blank?
        @tips = Xmt::Faq::Tip.where(opts).order(id: :desc).page(params[:page])
      end
      # GET /xmt_mgr/messages/1
      # GET /xmt_mgr/messages/1.json
      def show
      end
      # GET /xmt_mgr/messages/new
      def new
        @tip = Xmt::Faq::Tip.new
      end

      # GET /xmt_mgr/messages/1/edit
      def edit
      end
      # POST /xmt_mgr/messages
      # POST /xmt_mgr/messages.json
      def create
        @tip = Xmt::Faq::Tip.new(message_params)
        respond_to do |format|
          if @tip.save
            format.html { redirect_to xmt_mgr_tips_url(site_id: @site.id), notice: '留言添加成功.' }
            format.json { render :show, status: :created, location: @mgr_message }
          else
            format.html { render :new }
            format.json { render json: @message.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /xmt_mgr/messages/1
      # PATCH/PUT /xmt_mgr/messages/1.json
      def update
        respond_to do |format|
          if @tip.update(message_params)
            format.html { redirect_to xmt_mgr_tips_url(site_id: @site.id), notice: '回复成功.' }
            format.json { render :show, status: :ok, location: @mgr_message }
          else
            format.html { render :edit }
            format.json { render json: @message.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /xmt_mgr/messages/1
      # DELETE /xmt_mgr/messages/1.json
      def destroy
        @tip.destroy
        respond_to do |format|
          format.html { redirect_to  xmt_mgr_tips_url(site_id:@site.id), notice: '留言删除成功.' }
          format.json { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_message
        @tip = Xmt::Faq::Tip.find(params[:id])
      end

      def set_site
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def message_params
        params.require(:xmt_faq_tip).permit!
      end
    end
  end
end

