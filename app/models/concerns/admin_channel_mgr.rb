
class AdminChannelMgr
  include ::Singleton
  attr_reader :sites, :default_site, :channels

  def initialize
    load
  end

  def load
    @channels = Xmt::Press::Channel.all.order(seq: :asc).to_a
    @channel_menus = {}
    @channel_select_options = {}
    init_site
  end

  alias reload load

  def find_channel(id)
    @channels.detect {|c| c.id.to_s == id.to_s}
  end

  def find_site(id)
    @sites.detect {|c| c.id.to_s == id.to_s}
  end

  def init_site
    @sites = @channels.select {|c| c.class.name == 'Xmt::Press::Site'}
    @default_site = @sites.first
  end

  def channel_menu(site)
      b = SiteChannelBuilder.new(site)
      d = SiteChannelDirector.new(site, b)
      d.build(false)
      b.result.html_safe
  end


  def topic_channel_menu(site)
    unless @channel_menus[site.id.to_s]
      b = SiteTopicChannelBuilder.new(site)
      d = SiteTopicChannelDirector.new(site, b)
      d.build(false)
      @channel_menus[site.id.to_s] = b.result.html_safe
    end
    @channel_menus[site.id.to_s]
  end





  def stat_channel_menu(site)
    b = Xmt::Stat::StatYearChannelBuilder.new(site)
    d = Xmt::Stat::StatChannelDirector.new(site, b)
    d.build(false)
    @channel_menus[site.id.to_s] = b.result_stat.html_safe
    @channel_menus[site.id.to_s]
  end

  def stat_month_channel_menu(site)
    b = Xmt::Stat::StatMonthChannelBuilder.new(site)
    d = Xmt::Stat::StatChannelDirector.new(site, b)
    d.build(false)
    @channel_menus[site.id.to_s] = b.result_stat.html_safe
    @channel_menus[site.id.to_s]
  end

  def channel_options(site, type)
    unless @channel_select_options[site.id.to_s]
      @channel_select_options[site.id.to_s] = ChannelMap.new(site, type).nested_set_options()
    end
    @channel_select_options[site.id.to_s]
  end

end