class NavMainBuilder

  def initialize
    @tag = []
  end

  def header
    @tag << "<ul class='nav-main'>"
  end

  def node_begin(index)
    @tag << "<li id='li-#{index}'>"
  end

  def node_body(node)
    @tag << "#{node.title}"
  end

  def node_single(node)
    @tag << "<a href='/pages/#{node.id}' class=''>#{node.title}</a>"
  end

  def node_end
    @tag << "<span></span></li>"
  end

  def group_begin(index)
    @tag << "<div id='box-#{index}' class='hidden-box box0#{index}'><ul>"
  end

  def group_body(node)
    @tag << "<li><a href='/pages/#{node.id}' target='_blank'>#{node.title}</a></li>"
  end

  def group_end
    @tag << "</ul></div>"
  end

  def footer
    @tag << "</ul><div style='clear:both;'></div>"
  end

  def result
    @tag.join('')
  end
end