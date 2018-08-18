module Xmt
  module Test
    class Category
      include ModelBase
      include Mongoid::Tree
      include Mongoid::Tree::Traversal

      field :title, type: String

      has_many :questions, :class_name => 'Xmt::Test::Question'
      has_many :papers, :class_name => 'Xmt::Test::Paper'

      validates :title, presence: true, length: {maximum: 50}

      def ancestors_and_self_name_format
        names = []
        self.ancestors_and_self.each do |name|
          names << name.title
        end
        names.join('>>')
      end

    end
  end
end
