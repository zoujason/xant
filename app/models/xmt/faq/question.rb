module Xmt
  module Faq
    class Question
      include ModelBase
      field :title, type: String
      field :qty, type: String
      field :typ, type: String
      # 问题：单选，多选，默认单选
      field :sel_status, type: Boolean, default: false

      belongs_to :poll, class_name: 'Xmt::Faq::Poll'
      embeds_many :answers, class_name: 'Xmt::Faq::Answer'
    end
  end
end