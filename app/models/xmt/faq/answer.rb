module Xmt
  module Faq
    class Answer
      include ModelBase
      field :title, type: String
      field :qty, type: String
      field :pic, type: String

      embedded_in :question, class_name: 'Xmt::Faq::Question'
    end
  end
end