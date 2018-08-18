json.channels do
  json.array! @channels, partial: 'api/v1/channels/channel', as: :channel
end
