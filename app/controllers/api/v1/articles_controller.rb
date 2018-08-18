class Api::V1::ArticlesController < Api::V1::BaseController

  def index
    opts = {parent_id: params[:channel_id]}.delete_if {|key, value| value.blank? }
    @articles = Article.where(opts).page(params[:page])
  end

  def show
    @article = Article.find(params[:id])
  end

  def artlist
    pages = Xmt::Press::Article.publish
    if !pages.blank?
      headers['Access-Control-Allow-Origin'] = '*'
      render json: pages.map {|article| {title: article.title, picture: article.avatar_url(), url: article.linkpage.blank? ? "http://wdlczw.hljgov.com/pages/#{article.id}" : article.linkpage}}
    else
      render json: ''
    end
  end

end
