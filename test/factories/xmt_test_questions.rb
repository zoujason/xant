FactoryBot.define do


  factory :single, class: 'Xmt::Test::SingleChoice' do |q|
    q.content "测试试题1?"
    q.score 4
    before(:create) do |question, evaluator|
      question.answers.build(title: 'answer1', righted: true, score: 4 )
      question.answers.build(title: 'answer2', righted: false, score: 0  )
      question.answers.build(title: 'answer3', righted: false, score: 0 )
      question.answers.build(title: 'answer4', righted: false, score: 0  )
    end
  end


  factory :multi,class: 'Xmt::Test::MultipleChoice' do |m|
    m.content "多选测试1?"
    m.score 4
     before(:create) do |question, evaluator|
       question.answers.build(title: 'answer1', righted: true, score: 2 )
       question.answers.build(title: 'answer2', righted: false, score: 0  )
       question.answers.build(title: 'answer3', righted: false, score: 0 )
       question.answers.build(title: 'answer4', righted: true, score: 2  )
     end

  end







end