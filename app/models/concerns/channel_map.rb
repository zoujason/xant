class ChannelMap

  def initialize(channel,type = nil)
    @type = type
    @root = channel
    @channel = channel
    @channels = AdminChannelMgr.instance.channels

  end

  def children
    if @channel.nil?
      return []
    end
    if @type.nil?
      @channels.select { |node| node.parent_id == @channel.id }
    else
       @channels.select { |node| node.parent_id == @channel.id && node.res_name == @type }
    end
  end

  def nested_set_options
    opts ||= []
    names = []
    level = 0
    self.traverse do |item|
      names.pop(level - item.depth + 1) if level >= item.depth
      names << item.title
      opts << ["#{names.join('>>')}", item.id]
      level = item.depth
    end
    opts
  end

  def traverse(&block)
    result = [block.call(@channel)] + self.children.collect do |c|
      @channel = c
      self.send(:traverse, &block)
    end
    result.flatten
  end

  def traverse_map(&block)
    result = [block.call(@channel)] + self.children.collect do |c|
      @channel = c
      self.send(:traverse_map, &block)
    end
    result.flatten
  end

  def traversal(&block)
    self.children.collect do |child|
      block.call(child)
      @channel = child
      traversal(&block)
    end
  end

end