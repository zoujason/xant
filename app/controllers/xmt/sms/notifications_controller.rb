module Xmt
  module Sms
    class NotificationsController < AdminController
      before_action :set_notification, only: [:show, :edit, :update, :destroy]
      before_action :set_site
      # GET /notifications
      # GET /notifications.json
      def index
        @site ||= @sites.first
        @announcements = Xmt::Sms::Notification.where(site_id: @site.id).page(params[:page])
        unless params[:key].blank?
          key = /.*#{params[:key]}.*/
          @announcements = @announcements.where(title: key).page(params[:page])
        end
      end

      # GET /notifications/1
      # GET /notifications/1.json
      def show
      end

      # GET /notifications/new
      def new
        @announcement = Xmt::Sms::Notification.new
      end

      # GET /notifications/1/edit
      def edit
      end

      # POST /notifications
      # POST /notifications.json
      def create
        @announcement = Xmt::Sms::Notification.new(notification_params)
        respond_to do |format|
          if @announcement.save
            format.html {redirect_to xmt_sms_notifications_url(site_id: @site.id), Notification: '公告添加成功.'}
            format.json {render :show, status: :created, location: @announcement}
          else
            format.html {render :new}
            format.json {render json: @announcement.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /notifications/1
      # PATCH/PUT /notifications/1.json
      def update

        respond_to do |format|
          if @announcement.update!(notification_params)
            format.html {redirect_to xmt_sms_notifications_url(site_id: @site.id), Notification: '公告修改成功.'}
            format.json {render :show, status: :created, location: @announcement}
          else
            format.html {render :edit}
            format.json {render json: @announcement.errors, status: :unprocessable_entity}
          end
        end
      end


      # DELETE /notifications/1
      # DELETE /notifications/1.json
      def destroy
        @announcement.destroy
        respond_to do |format|
          format.html {redirect_to xmt_sms_notifications_url, Notification: '公告删除成功.'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_notification
        @announcement = Xmt::Sms::Notification.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def notification_params
        params.require(:xmt_sms_notification).permit!
      end

      def set_site
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
      end
    end
  end
end
