# encoding: utf-8
module Xmt
  module Press
    class ChannelsController < AdminController
      before_action :set_channel, only: [:show, :edit, :update, :destroy]
      before_action :set_site

      # GET /xmt/channels
      # GET /xmt/channels.json
      def index
        @menu_table = ChannelTableBuilder.new(@site)
        @menu_table.build
      end

      # GET /xmt/channels/1
      # GET /xmt/channels/1.json
      def show

      end

      # GET /xmt/channels/new
      def new
        @channel = Xmt::Press::Channel.new
      end

      # GET /xmt/channels/1/edit
      def edit
      end

      # POST /xmt/channels
      # POST /xmt/channels.json
      def create
        #cp = channel_params.to_h
        #p pic = cp.delete(:picture)
        @channel = Xmt::Press::Channel.new(channel_params)
        #pic = channel_params[:picture]
        #p Ckeditor::Picture.create(data: pic[:data])

        respond_to do |format|
          if @channel.save
            AdminChannelMgr.instance.reload
            format.html { redirect_to xmt_press_channels_url(site_id: @site.id), notice: '频道添加成功.' }
            format.json { render :show, status: :created, location: @channel }
          else
            format.html { render :new }
            format.json { render json: @channel.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /xmt/channels/1
      # PATCH/PUT /xmt/channels/1.json
      def update
        #channel_params[:picture] = {data: params[:file]} # Ckeditor::Picture.new(data: params[:file])

        respond_to do |format|
          if @channel.update!(channel_params)
            AdminChannelMgr.instance.reload
            format.html { redirect_to xmt_press_channels_url(site_id: @site.id), notice: '频道修改成功.' }
            format.json { render :show, status: :ok, location: @channel }
          else
            format.html { render :edit }
            format.json { render json: @channel.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /xmt/channels/1
      # DELETE /xmt/channels/1.json
      def destroy
        if @channel.articles.blank?
          @channel.destroy
          AdminChannelMgr.instance.load
          respond_to do |format|
            format.html { redirect_to xmt_press_channels_url(site_id: @site.id), notice: '频道删除成功.' }
            format.json { head :no_content }
          end
        else
          redirect_to xmt_press_channels_url(site_id: @site.id), notice: '该频道存在子文章，暂不能删除！'
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_channel
        @channel = AdminChannelMgr.instance.find_channel(params[:id])
      end

      def set_site
        @sites = AdminChannelMgr.instance.sites
        @site = AdminChannelMgr.instance.find_site(params[:site_id]) || AdminChannelMgr.instance.default_site
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def channel_params
        params.require(:xmt_press_channel).permit!
      end
    end
  end

end
