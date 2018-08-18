class TreeDirector

  def initialize(node, builder)
    @node = node
    #@nodes = [@nodes] unless @nodes.is_a?(Array)
    @builder = builder
  end

  def build_nodes(node)
    unless node.leaf?
      @builder.group_begin
      node.children.each do |child|
        @builder.node_begin(child)
        @builder.node_body(child)
        build_nodes(child)
        @builder.node_end
      end
      @builder.group_end
    end
  end

  def build(show_root = true)

    nodes = show_root ? [@node] : @node.children

    @builder.header
    nodes.each do |node|
      @builder.node_begin(node)
      @builder.node_body(node)
      build_nodes(node)
      @builder.node_end
    end
    @builder.footer
  end

end