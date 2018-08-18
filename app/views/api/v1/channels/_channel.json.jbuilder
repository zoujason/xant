json.channel do
  json.extract! channel, :id, :title, :subtitle, :cont, :navigable
  # json.created_at (channel.created_at.strftime('%Y-%m-%d %H:%M:%S'))
  # json.updated_at (channel.updated_at.strftime('%Y-%m-%d %H:%M:%S'))
end

#json.url channel_url(channel, format: :json)