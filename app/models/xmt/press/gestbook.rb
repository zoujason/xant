module Xmt
  module Press
    class Gestbook  < Page
      field :reply, type: String, default: ''
      field :reply_at, type: DateTime, default:->{Time.now}
      field :ispub, type: String, default: false
      field :isshow, type: String, default: false
      belongs_to :channel, class_name: 'Xmt::Press::Channel', foreign_key: :parent_id, inverse_of: :articles, dependent: :nullify
    end
  end
end