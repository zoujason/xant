module ApplicationHelper
  # def content_tag(name, content = nil, options = nil, escape = true, &block)
  #   if block_given?
  #     options = content if content.is_a?(Hash)
  #     content = capture(&block)
  #   end
  #   content_tag_string(name, content, options, escape)
  # end

  #options = {new_top: true, hot_top:true, order_by: true}
  #partial: partial template;

  def render_hot_articles(channel_id, limit,partial,options)
    articles = Article.where(parent_id: channel_id).order_by(hits: 1).limit(limit)
    render "#{partial}", articles: articles
  end

  def fiexslider(args)
    str = []
    str << '<div class="flexslider" data-plugin-options=\'{"controlNav":false,sync: "#carousel"}\'>'
    str << '<ul class="slides">'
    # Article.where(parent_id: args[:channel_id]).limit(args[:limit]).each do |article|
    Article.all.limit(args[:limit]).each do |article|
      str << '<li>'
      str << "<a class='group1' href='#{article.id ? '/assets/edu/image02.jpg' : article.id}'>"
      str << "<img src='#{article.id ? '/assets/edu/image02.jpg' : article.id}'>"
      str << '<span class="image-overlay"> <i class="clip-expand circle-icon circle-main-color"></i> </span>'
      str << '</a>'
      str << '</li>'
    end
    str << '</ul>'
    str << '</div>'
    str << '<div id="carousel" class="flexslider animate-group" data-plugin-options=\'{"itemWidth": 120, "itemMargin": 5}\'>'
    str << '<ul class="slides">'
    # Article.where(parent_id: args[:channel_id]).limit(args[:limit]).each do |article|
    Article.all.limit(args[:limit]).each do |article|
      str << '<li>'
      str << "<img src='#{article.id ? '/assets/edu/image02.jpg' : article.id}' class='animate' data-animation-options=\"{animation:'fadeIn', duration:'600'}\">"
      str << '</li>'
    end
    str << '</ul>'
    str << '</div>'
    str.join('').html_safe
  end


  # 20161104 代码块 图片+文字+导读  style1
  # eg: img_title(class:'col-md-6 col-sm-6', channel_id: "581ab078c0ac081aa059b6d2", limit: 2)

  def img_title(args, &block)
    str = []
    # Article.where(parent_id: args[:channel_id]).limit(args[:limit]).each do |article|
    Article.all.limit(args[:limit]).each do |article|
      unless block_given?
        str << "<li class='#{args[:class]}'>"
        str << '<div class="thumbnail">'
        str << "<img src='#{article.id ? '/assets/edu/team-5.jpg' : article.picurl}' class='animate' alt="" data-animation-options=\"{'animation' : 'fadeInRight', 'duration' : '300'}\">"
        str << "<span class='image-overlay'><a target='_blank' href='/pages/#{article.id}'><i data-original-title='viewmore' data-placement='top' class='tooltips fa fa-linkedin circle-icon circle-small'></i></a></span>"
        str << '</div>'
        str << "<h3>#{article.title}</h3>"
        str << '<div>'
        str << "#{article.title}"
        str << '</div>'
        str << '<div itemprop="description" class="team-member-description">'
        str << '<p>'
        str << "#{article.title}"
        str << '</p>'
        str << '</div>'
        str << '</li>'
      else
        block.call(article)
      end
    end
    str.join('').html_safe
  end


  # 20161103 轮播图文 style1
  def fiexslider_article(channel_id,limit)
    str = []
    bb = FlexsliderBuilder.new
    # nn = Article.all.where(parent_id: channel_id).order_by(hits: 1).limit(limit)
    nn = Article.all
    dd = FiexsliderDirector.new(nn,bb)
    dd.build(:img_carousel)
    str = bb.result.html_safe
  end

  # 20161104 轮播图文style2
  def fiexslider_single_article(channel_id,limit)
    str = []
    bb = FlexsliderBuilder.new
    # nn = Article.all.where(parent_id: channel_id).order_by(hits: 1).limit(limit)
    nn = Article.all
    dd = FiexsliderDirector.new(nn,bb)
    dd.build(:single)
    str = bb.result.html_safe
  end

  # 20161102 代码块模式：文章标题+简介列表
  def title_info_style1(args,&block)
    str = []
    # Article.where(parent_id: args[:channel_id]).limit(args[:limit]).each do |article|
    Article.all.limit(args[:limit]).each do |article|
      unless block_given?
        str << '<div class="col-sm-4">'
        str << '<div class="core-box">'
        str << '<div class="heading">'
        str << '<i class="clip-mobile circle-icon"></i>'
        str << "<h2>#{article.title}</h2>"
        str << '</div>'
        str << '<div class="content">'
        str << "#{article.cont}Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
        str << '</div>'
        str << "<a class='views-more' href='/pages/#{article.id}'>"
        str << 'Type2 More<i class="fa fa-angle-right"></i>'
        str << '</a>'
        str << '</div>'
        str << '</div>'
      else
        block.call(article)
      end
    end
    str.join('').html_safe
  end


  # 20161102 代码块模式：文章图片+标题列表
  def title_img(args,&block)
    str = []
    # Article.where(parent_id: args[:channel_id]).limit(args[:limit]).each do |article|
    Article.all.limit(args[:limit]).each do |article|
      unless block_given?
        str << '<div class="col-md-3 col-sm-6">'
        str << '<div class="grid-item animate">'
        str << "<a href='/pages/#{article.id}'>"
        str << '<div class="grid-image">'
        str << "<img src='#{article.id ? '/assets/edu/image02.jpg' : article.id}' class='img-responsive'>"
        str << '<span class="image-overlay"> <i class="fa fa-mail-forward circle-icon circle-main-color"></i></span>'
        str << '</div>'
        str << "<div class='grid-content'>#{article.title}</div>"
        str << '</a>'
        str << '</div>'
        str << '</div>'
      else
        block.call(article)
      end
    end
    str.join('').html_safe
  end

  # 20161102  代码块模式：文章标题+简介列表style2
  def title_info_style2(args, &block)
    str = []
    # Article.where(parent_id: args[:channel_id]).limit(args[:limit]).each do |article|
    Article.all.limit(args[:limit]).each do |article|
      unless block_given?
        str << '<li>'
        str << "<h4><a href='/pages/#{article.id}'>"
        str << "#{article.title}</h4></a>"
        str << '<p>'
        str << "#{article.cont}Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in."
        str << '</p>'
        str << '</li>'
      else
        block.call(article)
      end
    end
    str.join('').html_safe
  end



  # 20161101文章标题列表
  def display_article_list(channel_id,limit)
    str = []
    bb = Articlebuilder.new
    nn = Article.all.where(parent_id: channel_id).order_by(hits: 1).limit(limit)
    dd = ArticleDirector.new(nn,bb)
    dd.build(:title)
    str = bb.result.html_safe
  end

  # 20161101 文章图片+标题列表
  def display_article_image_list(channel_id,limit)
    str = []
    bb = Articlebuilder.new
    nn = Article.all.where(parent_id: channel_id).order_by(hits: 1).limit(limit)
    dd = ArticleDirector.new(nn,bb)
    dd.build(:img_text)
    str = bb.result.html_safe
  end


  # 文章图片+标题列表
  def render_article_img2_top(nums)
    str = []
    Article.limit(nums).each do |article|
      str << '<li>'
      str << '<div class="post-image">'
      str << '<div class="img-thumbnail">'
      str << "<a href='/pages/#{article.id}'>"
      str << "<img src='#{article.id ? '/assets/edu/image02.jpg' : article.id}' style='height:50px;width:50px'>"
      str << '</a></div>'
      str << '</div>'
      str << "<div class='post-info'><a href='/pages/#{article.id}'>#{article.title}</a></div>"
      str << '<div class="post-meta">'
      str << 'Jan 10, 2014'
      str << '</div>'
      str << '</li>'
    end
    str.join('').html_safe
  end



  # 文章标题列表
  def render_article_titlelist_top(num)
    str = []
    Article.limit(num).each do |article|
      str << '<li>'
      str << "<a href='/pages/#{article.id}'>"
      str << "#{article.title}</a>"
      str << '</li>'
    end
    str.join('').html_safe
  end

  # 频道菜单导航
  def render_site_nav(channels)
    str = []
    channels.each do |channel|
      str << '<li>'
      str << "<a href='/pages/#{channel.id}'>"
      str << "#{channel.title}</a>"
      str << '</li>'
    end
    str.join('').html_safe
  end

  # 带子栏目频道菜单导航
  def display_nav_menu
    #m = Menu.find_by(sign: "SysMenu")
    b = NavBuilder.new
    d = TreeDirector.new(@site, b)
    d.build(false)
    b.result.html_safe
  end

  def box(args)
    str = ""
    str << '<div class="box">'
    str << '<h2>'
    str << "<img src='/images/icons/#{args[:icon]}.png' />"
    str << args[:title]
    str << '</h2>'
    str << '<div class="content">'
    5.times {
    str << "#{yield}"
    }
    str << '</div>'
    str << '</div>'
    str.html_safe
  end

  def box_accordion(args)
    str = []
    # Article.where(parent_id: args[:channel_id]).limit(args[:limit]).each do |article|
    Article.all.limit(args[:limit]).each do |article|
      str << '<div class="panel-group accordion-custom accordion-teal" id="accordion">'
      str << '<div class="panel panel-default">'
      str << '<div class="panel-heading">'
      str << '<h4 class="panel-title">'
      str << '<a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#" aria-expanded="false">'
      str << '<i class="icon-arrow"></i>'
      str << "#{article.title}"
      str << '</a>'
      str << '</h4>'
      str << '</div>'
      str << "<div id='collapse#{article.title}' class='panel-collapse collapse' aria-expanded='false' style='height: 0px;'>"
      str << '<div class="panel-body">'
      str << '<p>'
      str << "#{article.title}"
      str << '</p>'
      str << '</div>'
      str << '</div>'
      str << '</div>'
      str << '</div>'
    end
  end

end