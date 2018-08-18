module Xmt
  module Faq
    class MessagesController < AdminController
      before_action :set_message, only: [:show, :edit, :update, :destroy]
      before_action :set_site_gbook
      # GET /xmt/messages
      # GET /xmt/messages.json
      def index
        @messages = Xmt::Faq::Message.where(site_id: @site.id).page(params[:page])
        unless params[:key].blank?
          key = /.*#{params[:key]}.*/
          @messages = @messages.where(title: key).page(params[:page])
        end
      end

      # GET /xmt/messages/1
      # GET /xmt/messages/1.json
      def show
      end

      # GET /xmt/messages/new
      def new
        @message = Xmt::Faq::Message.new
      end

      # GET /xmt/messages/1/edit
      def edit
      end

      # POST /xmt/messages
      # POST /xmt/messages.json
      def create
        @message = Xmt::Faq::Message.new(message_params)
        respond_to do |format|
          if @message.save
            format.html {redirect_to xmt_faq_messages_url(site_id: @site.id), notice: '留言添加成功.'}
            format.json {render :show, status: :created, location: @mgr_message}
          else
            format.html {render :new}
            format.json {render json: @message.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/messages/1
      # PATCH/PUT /xmt/messages/1.json
      def update
        respond_to do |format|
          if @message.update(message_params)
            format.html {redirect_to xmt_faq_messages_url(site_id: @site.id), notice: '留言修改成功.'}
            format.json {render :show, status: :ok, location: @mgr_message}
          else
            format.html {render :edit}
            format.json {render json: @message.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/messages/1
      # DELETE /xmt/messages/1.json
      def destroy
        @message.destroy
        respond_to do |format|
          format.html {redirect_to xmt_faq_messages_url(site_id: @site.id), notice: '留言删除成功.'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_message
        @message = Xmt::Faq::Message.find(params[:id])
      end

      def set_site_gbook
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])


      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def message_params
        params.require(:xmt_faq_message).permit!
      end
    end
  end
end

