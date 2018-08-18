module Xmt
  module Press
    class TopicsController < AdminController
      before_action :set_topic, only: [:show, :edit, :update, :destroy]
      before_action :set_site_and_channel


      # GET /xmt/topics
      # GET /xmt/topics.json
      def index
        opts = {
            parent_ids: @site.id,
            status: params[:status],
            headline_level: params[:head],
            rcmd_level: params[:rcmd]
        }.delete_if {|k,v|v.blank?}
        opts[:parent_id] = params[:channel_id] unless params[:channel_id].blank?
        opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?
        @topics = Topic.includes(:channel).where(opts).order(id: :desc).page(params[:page])
      end

      # GET /xmt/topics/1
      # GET /xmt/topics/1.json
      def new
           @topic = Topic.new(published_at: Time.now)
      end


      def show

      end
      # GET /xmt/topics/new
      def upload_assets

      end

      def wirte_assets
        ZipUtil.extract_from_zip_file(params[:file].path,@site)
        redirect_to upload_assets_xmt_press_topics_url,notice: '资源导入成功.'
      end

      def upload_template

      end

      def wirte_template
        ZipUtil.extract_from_zip_file(params[:file].path,@site)
        redirect_to upload_template_xmt_press_topics_url,notice: '专题导入成功.'
      end

      # GET /xmt/topics/1/edit
      def edit

      end

      # POST /xmt/topics
      # POST /xmt/topics.json
      def create
        pictures = topic_params.delete(:pictures)
        @topic = Topic.new(topic_params)
        @topic.cont =  @topic.sensitive(@sensitives,topic_params[:cont])
        respond_to do |format|
          if @topic.save
            unless pictures.blank?
              @topic.pictures = []
              pictures.each do |f|
                @topic.pictures.create(pic: f)
              end
            end
            format.html { redirect_to xmt_press_topics_url(channel_id: topic_params[:parent_id],site_id:@site.id), notice: '文章创建成功.' }
            format.json { render :show, status: :created, location: topic }
          else
            format.html { render :new }
            format.json { render json: @topic.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /xmt/topics/1
      # PATCH/PUT /xmt/topics/1.json
      def update
        pictures = topic_params.delete(:pictures)
        topic_params[:cont] =  @topic.sensitive(@sensitives,topic_params[:cont])
        respond_to do |format|
          if @topic.update(topic_params)
            unless pictures.blank?
              @topic.pictures = []
              pictures.each do |f|
                @topic.pictures.create(pic: f)
              end
            end
            format.html { redirect_to xmt_press_topics_url(channel_id: topic_params[:parent_id],site_id:@site.id), notice: '文章更新成功.' }
            format.json { render :show, status: :ok, location: @topic }
          else
            format.html { render :edit }
            format.json { render json: @topic.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /xmt/topics/1
      # DELETE /xmt/topics/1.json
      def destroy
        @topic.destroy
        respond_to do |format|
          format.html { redirect_to xmt_press_topics_url(site_id: @site.id, channel_id: @channel.id), notice: '文章删除成功.' }
          format.json { head :no_content }
        end
      end

      def channel_topics

      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_topic
        @topic = Topic.find(params[:id])
      end




      def set_site_and_channel
        @sites = Site.all
        @site =  params[:site_id].blank? ? Site.first : Site.where(id: params[:site_id]).first
        @channel = params[:channel_id].blank? ? (@site.channels.first) : Channel.where(id: params[:channel_id]).first
        @sensitives = Sensitive.where(enable:true)
        @channel_root = Channel.where(parent_ids:@site.id).first
        @channel_map = ChannelMap.new(@channel_root)
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def topic_params
        params.require(:xmt_press_topic).permit!
      end

    end

  end
end
