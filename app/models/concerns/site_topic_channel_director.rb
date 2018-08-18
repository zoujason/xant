class SiteTopicChannelDirector

  def initialize(site, builder)
    @site = site
    @nodes = Xmt::Press::Channel.where(parent_ids: site.id).to_a
    @builder = builder
  end

  def find_by_parent_id(parent_id)
    @nodes.select { |node| node.parent_id == parent_id }
  end

  def build_nodes(node)
    if Waas::Security.subject.allow(node.id,'visite')
      children = find_by_parent_id(node.id)
      if children.size > 0
        @builder.group_begin
        @builder.group_body(node)

        children.each do |child|
          build_nodes(child)
        end
        @builder.group_end
      else
        @builder.node_begin
        @builder.node_body(node)
        @builder.node_end
      end
    end
  end

  def build(show_root = false)
    @builder.header
    nodes = show_root ? [@site] : find_by_parent_id(@site.id)
    nodes.each do |node|
      build_nodes(node)
    end
    @builder.footer
  end

end