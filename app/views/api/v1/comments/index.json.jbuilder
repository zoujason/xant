json.comments do
  json.array! @comments, partial: 'api/v1/comments/comment', as: :comment
end
