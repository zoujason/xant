module PagesHelper
  #-------- template helper method --------

  def hlp_list_article(parent, options = {count: 20})
    query_condition = {}
    order_by = {seq: -1, published_at: -1}
    unless options[:headline_level].blank?
      query_condition[:headline_level] = options[:headline_level]
    end
    unless options[:rcmd_level].blank?
      query_condition[:rcmd_level] = options[:rcmd_level]
    end
    unless options[:sort].blank?
      sort = options[:sort]
      order_by = {"#{sort}": -1, seq: -1,published_at: -1}
    end
    unless options[:count].blank?
      count = options[:count]
    end
    @hlp_current_list = Xmt::Press::Article
    parents = parent.to_s.split(',')
    parent_ids = []
    parents.each do |id|
      parent_ids.push(BSON::ObjectId(id.strip))
    end

    @hlp_current_list = if !options[:load_all].blank? && options[:load_all].to_s == 'true'
                          @hlp_current_list.where(query_condition).in(parent_ids: parent_ids).order(order_by).page(params[:page]).per(count)
                        else
                          @hlp_current_list.where(query_condition).in(parent_id: parent_ids).order(order_by).page(params[:page]).per(count)
                        end

  end

  def hlp_list_channel(parent, options = {})
    order_by = {seq: -1}
    unless options[:count].blank?
      count = options[:count]
    end
    @hlp_current_list = Xmt::Press::Channel.navigable
    parents = parent.to_s.split(',')
    parent_ids = []
    parents.each do |id|
      parent_ids.push(BSON::ObjectId(id.strip))
    end
    @hlp_current_list = if !options[:load_all].blank? && options[:load_all].to_s == 'true'
                          @hlp_current_list.in(parent_ids: parent_ids).order(order_by).page(params[:page]).per(count)
                        else
                          @hlp_current_list.in(parent_id: parent_ids).order(order_by).page(params[:page]).per(count)
                        end
  end

  def hlp_current_list
    @hlp_current_list
  end

  #------- end ------------------------------

  def hlp_page(id)
    @temp_pages ||= {}
    @temp_pages[id] ||= Xmt::Press::Page.where(id: id).first
  end

  def hlp_html_title(page, set_title = nil)
    base_title = set_title ||= page.site.title
    if page.is_a? Xmt::Press::Site
      web_title = base_title
    elsif page.is_a? Xmt::Press::Channel
      web_title = base_title + '-' + page.title
    elsif page.is_a? Xmt::Press::Article
      web_title = base_title + '-' + page.parent.title + '-' + page.title
    else
      web_title = base_title + '-' + page.title
    end
    web_title
  end

  def hlp_active_channel(page, channel_id)
    page.ancestors_and_self(&:id).include?(channel_id)
  end

  def hlp_site_map(site)
    SiteMapBuilder.new(site).build
  end

end
