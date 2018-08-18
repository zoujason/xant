json.article do
  json.extract! article, :id, :title, :cont, :author, :published_at
  json.picture (article.avatar.try(:url))
  json.published_at (article.published_at.strftime('%Y-%m-%d %H:%M:%S'))
  json.creator (article.created_by)
  #json.tags (json.array (article.tags, :title))
end
#json.url article_url(article, format: :json)