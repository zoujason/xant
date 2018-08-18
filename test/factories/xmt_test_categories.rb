FactoryBot.define do
  factory :category_one, class: 'Xmt::Test::Category' do |c|
    c.title "parent"

  end
  factory :category_two, class: 'Xmt::Test::Category' do |c|
    c.title "anthor"
  end
end