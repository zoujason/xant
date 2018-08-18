json.comment do
  json.extract! comment, :id, :title, :cont, :author, :created_by_id
  json.created_at (comment.created_at.strftime('%Y-%m-%d %H:%M:%S'))
  json.replies (json.array(comment.replies, :id, :cont, :author, :created_by_id, :parent_id))
end
#json.url article_url(article, format: :json)