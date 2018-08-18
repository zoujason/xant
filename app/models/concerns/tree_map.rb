class TreeMap

  def initialize(node)
    @root = node
    @current = @root
    @nodes = @root.descendants.to_a
  end

  def find_children(parent_id)
    @nodes.select { |node| node.parent_id == parent_id }
  end

  def traversal(&block)
    block.call(@current)
    find_children(@current.id).each do |child|
      @current = child
      traversal(&block)
    end
  end

end