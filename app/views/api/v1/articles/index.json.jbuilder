json.articles do
  json.array! @articles, partial: 'api/v1/articles/article', as: :article
end
