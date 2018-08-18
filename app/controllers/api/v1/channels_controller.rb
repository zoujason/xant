class Api::V1::ChannelsController < Api::V1::BaseController
  def index
    opts = {parent_id: params[:site_id] || params[:channel_id]}.delete_if {|key, value| value.blank? }
    @channels = Channel.where(opts).page(params[:page])
  end

  def show
    @channel = Channel.find(params[:id])
  end

end
