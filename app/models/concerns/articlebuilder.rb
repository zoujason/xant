class Articlebuilder
  def initialize
    @tag = []
  end

  def article_begin
    @tag << '<ul class="">'
  end

  def article_title(article)
    @tag << "<li class='title'><a href ='/articles/#{article.id}'>#{article.title}</a></li>"
  end

  def article_image(article)
    @tag << "<img src='#{article.picurl ? '/assets/edu/image01.jpg' : article.picurl}' class='img-responsive'>"
  end

  def article_desc(article)
    @tag << "#{article.cont}"
  end

  def article_end
    @tag << '</ul>'
  end

  def result
    @tag.join('')
  end



end