class NavBuilder

  def initialize
    @tag = []
  end

  def header
    @tag << "<ul class='nav navbar-nav navbar-right'>"
  end

  def node_begin(node)
    @tag << "<li>"
  end

  def node_body(node)
      @tag << "<a href='/pages/#{node.id}' class=''>#{node.title}</a>"
  end

  def node_end
    @tag << "</li>"
  end

  def group_begin
    @tag << "<li class='dropdown-submenu'>"
  end

  def group_body(node)
    @tag << "<a href='/pages/#{node.id}' class='dropdown-toggle'data-toggle='dropdown' data-hover='dropdown'>#{node.title}</a><ul class='dropdown-menu'>"
  end

  def group_end
    @tag << "</ul></li>"
  end

  def footer
    @tag << "</ul>"
  end

  def result
    @tag.join('')
  end
end