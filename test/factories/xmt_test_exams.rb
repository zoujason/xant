FactoryBot.define do

  factory :exam_random_with_papers, class: 'Xmt::Test::Exam' do |e|
    e.title "自动试卷"
    e.mode "random"
    e.category_id 1
    before(:create) do |exam, evaluator|
      exam.type_rules.build(question_type: 'Xmt::Test::SingleChoice', question_size: 2, score: 5)
      exam.type_rules.build(question_type: 'Xmt::Test::MultipleChoice', question_size: 2, score: 5  )
    end

    before(:create) do |exam, evaluator|
      10.times do
        exam.papers.build()
      end
    end

  end

  factory :exam_random_no_papers, class: 'Xmt::Test::Exam' do |e|
    e.title "自动试卷2"
    e.mode "random"
    e.category_id 1

    before(:create) do |exam, evaluator|
      exam.type_rules.build(question_type: 'Xmt::Test::SingleChoice', question_size: 2, score: 5)
      exam.type_rules.build(question_type: 'Xmt::Test::MultipleChoice', question_size: 2, score: 5  )
    end
  end

  5.times do |t|
    factory "single#{t}", class: 'Xmt::Test::SingleChoice' do |q|
      q.content "测试试题#{t}?"
      q.score 5
      q.category_id 1
      before(:create) do |question, evaluator|
        question.answers.build(title: 'answer1', righted: true, score: 5 )
        question.answers.build(title: 'answer2', righted: false, score: 0  )
        question.answers.build(title: 'answer3', righted: false, score: 0 )
        question.answers.build(title: 'answer4', righted: false, score: 0  )
      end
    end
  end
  4.times do |t|
    factory "multiple#{t}",class: 'Xmt::Test::MultipleChoice' do |m|
      m.content "多选测试#{t}?"
      m.score 4
      m.category_id 1
      before(:create) do |question, evaluator|
        question.answers.build(title: 'answer1', righted: true, score: 2 )
        question.answers.build(title: 'answer2', righted: false, score: 0  )
        question.answers.build(title: 'answer3', righted: false, score: 0 )
        question.answers.build(title: 'answer4', righted: true, score: 2  )
      end

    end
  end

end