class SiteChannelBuilder
  def initialize(site)
    @site = site
    @tag = []
  end

  def header
    @tag << "<ul class='dropdown-menu dropdown-info dropdown-menu-step'>"
  end

  def node_begin
      @tag << "<li>"
  end

  def node_body(node)
      @tag << "<a href='/xmt/press/articles?channel_id=#{node.id}&site_id=#{@site.id}' >#{node.title}</a>"
  end

  def node_end
    @tag << "</li>"
  end


  def group_begin
      @tag << "<li>"
  end

  def group_body(node)
    @tag << "<a href='/xmt/press/articles?channel_id=#{node.id}&site_id=#{@site.id}'><i class='fa fa-angle-right menu-item-right'></i>#{node.title}</a><ul class='dropdown-menu-child'>"
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