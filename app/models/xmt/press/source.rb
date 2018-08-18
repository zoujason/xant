module Xmt
  module Press
    class Source < Article
      has_and_belongs_to_many :relationships, class_name: 'Xmt::Press::Source',  inverse_of: nil, validate: false
    end

  end
end