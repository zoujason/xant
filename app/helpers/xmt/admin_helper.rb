module Xmt::AdminHelper
  def menu_render
    session[:m_id] = params[:m_id] || session[:m_id] || Xmt::Nav::MenuItem.first.id.to_s
    AdminMenuMgr.instance.render(session[:m_id]).html_safe
  end

  # 带子栏目频道菜单导航
  def mgr_nav_menu
    #m = Menu.find_by(sign: "SysMenu")
    b = NavBuilder.new
    d = TreeDirector.new(@site, b)
    d.build(false)
    b.result.html_safe
  end

  # == Usage
  #
  #   <%= f.select :parent_id, nested_set_options(node, depth) {|i| "#{'–' * i.depth} #{i.name}" } %>
  #   <%= f.select :parent_id, nested_set_options(@current.org, Bur::Bureau), :include_blank => true %>
  #
  def nested_set_options(node, klass, show_root=true)
    result ||= []
    d = node.depth
    node.traverse do |item|
      result << ["#{'　' * (show_root ? (item.depth - d) : (item.depth - (d+1)))} #{item.name}", item.id] if item.is_a?(klass) and (show_root ? (d <= item.depth) :  (d < item.depth))
    end
    result
  end


  def icon(icon, text="", html_options={})
    content_class = "fa #{icon}"
    content_class << " #{html_options[:class]}" if html_options.key?(:class)
    html_options[:class] = content_class

    html = content_tag(:i, nil, html_options)
    html << " #{text}" unless text.blank?
    html.html_safe
  end


  # 站点-》栏目
  def mgr_site_channel(site)
    # b = SiteChannelBuilder.new(site)
    # d = SiteChannelDirector.new(site, b)
    # d.build(false)
    # b.result.html_safe
    AdminChannelMgr.instance.channel_menu(site)
  end


  # 站点-》专题 -》栏目
  def mgr_site_topic_channel(site)
    # b = SiteChannelBuilder.new(site)
    # d = SiteChannelDirector.new(site, b)
    # d.build(false)
    # b.result.html_safe
    AdminChannelMgr.instance.topic_channel_menu(site)
  end


  # 统计-》站点-》栏目
  def mgr_stat_channel(site)
    Xmt::Stat::StatChannelMgr.instance.channel_menu_stat(site)
  end

  # 统计-》站点-》栏目
  def mgr_stat_month_channel(site)
    Xmt::Stat::StatChannelMgr.instance.channel_menu_stat_month(site)
  end

  # 站点-》留言
  def mgr_site_gbook(site)
    #m = Menu.find_by(sign: "SysMenu")
    b = SiteChannelBuilder.new(site)
    d = SiteChannelDirector.new(site, b)
    d.build(false)
    b.result.html_safe
  end

end
