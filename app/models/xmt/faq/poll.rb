module Xmt
  module Faq
    class Poll
      include ModelBase

      field :title, type: String
      field :start_at, type: Date
      field :end_at, type: Date
      field :interval_hour
      field :status

      has_many :questions, class_name: 'Xmt::Faq::Question'
      belongs_to :site, class_name: 'Xmt::Press::Site'

      def self.save_answer(answers)
          answers.each do |key, value|
            ans = Xmt::Faq::Question.find(key).answers
            if value.to_s.length > key.to_s.length
              value.each do |key,val_key|
                a = ans.find(val_key)
                qty = a.qty.to_i+1
                a.qty = qty
                a.save
              end
            else
              a = ans.find(value)
              qty = a.qty.to_i+1
              a.qty = qty
              a.save
            end
          end
      end
    end
  end
end