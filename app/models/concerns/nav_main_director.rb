class NavMainDirector

  def initialize(site, builder)
    @site = site
    @nodes = Xmt::Press::Channel.where(parent_ids: site.id).to_a
    @builder = builder
  end

  def find_by_parent_id(parent_id)
    @nodes.select { |node| node.parent_id == parent_id }
  end

  def build_nodes(node)
    children = find_by_parent_id(node.id)
    if children.size > 0
      @builder.node_body(node)
    else
      @builder.node_single(node)
    end
  end


  def build(show_root = false)
    @builder.header
    nodes = show_root ? [@site] : find_by_parent_id(@site.id)
    nodes.each_with_index do |node, index|
      i=index+1
      @builder.node_begin(i)
      build_nodes(node)
      @builder.node_end
    end
    @builder.footer
    nodes.each_with_index do |node, index|
      children = find_by_parent_id(node.id)
      if children.size > 0
        i=index+1
        @builder.group_begin(i)
        children.each do |child|
          @builder.group_body(child)
        end
        @builder.group_end
      end
    end

  end

end