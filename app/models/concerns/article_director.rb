class ArticleDirector

  def initialize(articles, builder)
    @articles = articles
    @builder = builder
  end

  def build_articles
    @articles.each do |article|
      @builder.article_title(article)
    end
  end

  alias :old_build_articles :build_articles
  def build_articles
    @builder.article_begin
    old_build_articles
    @builder.article_end
  end

  def build_image_articles
    @articles.each do |article|
      @builder.article_image(article)
      @builder.article_title(article)
    end
  end

  def build_desc_articles
    @articles.each do |article|
      @builder.article_title(article)
      @builder.article_desc(article)
    end
  end

  def build_image_desc_articles
    @articles.each do |article|
      @builder.article_image(article)
      @builder.article_title()
      @builder.article_desc(ararticleticle)
    end
  end

  def build(type=:title)
    @builder.article_begin
    case type
      when :title
        build_articles
      when :img_text
        build_image_articles
      when :desc
        build_desc_articles
      when :img_title_desc
        build_image_desc_articles
    end
    @builder.article_end
  end


end