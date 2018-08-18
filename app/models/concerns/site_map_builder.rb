class SiteMapBuilder

  attr_reader :site, :depth_limit

  def initialize(site, depth_limit=1)
    @site = site
    @depth_limit = depth_limit
    @tag = []
  end

  # <a href="<%= channel.url %>" class="one_level"><%= channel.attr(:title) %></a>
  def build
    children_list(@site)
    @tag.join("").html_safe
  end

  def children_list(channel)
    return false if channel.depth > @depth_limit
    @tag << "<ul>"
    Xmt::Press::Channel.where({parent_id:channel.id,navigable:true}).each do |c|
      @tag << "<li class='map_level_#{c.depth}'>"
      @tag << "<a href='#{c.url}' >#{c.title}</a>"
      children_list(c) unless c.leaf?
      @tag << "</li>"
    end
    @tag << "</ul>"
  end
end
