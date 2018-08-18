module Xmt
  module Press
    class Board < Page
      has_many :pages, class_name: 'Xmt::Press::Page', foreign_key: :parent_id, inverse_of: :board, validate: false, autosave: true
    end
  end
end