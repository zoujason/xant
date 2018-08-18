# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Rake::Task["xmt:user_and_role_setup"].invoke
Rake::Task["xmt:site_setup"].invoke
Rake::Task["xmt:menu_setup"].invoke
Rake::Task["xmt:dict_setup"].invoke

category=Xmt::Test::Category.create(title: "党建基础")
category2=Xmt::Test::Category.create(title: "计算机基础")
20.times do |n|
  content = Faker::Lorem.sentence(10)+'?'

  question = Xmt::Test::SingleChoice.create(content: content,
                                       score: 4,
                                       category_id: category2.id)

  question.answers.create(title: Faker::Lorem.sentence(3),
                          righted: true,
                          score: 4)
  3.times do |t|
    question.answers.create(title: Faker::Lorem.sentence(3),
                            righted: false,
                            score: 0)
  end
end

30.times do |n|
  content = Faker::Lorem.sentence(10)+'?'

  question = Xmt::Test::SingleChoice.create(content: content,
                                           score: 4,
                                       category_id: category2.id)
  3.times do |t|
    question.answers.create(title: Faker::Lorem.sentence(3),
                            righted: false,
                            score: 0)
  end
  question.answers.create(title: Faker::Lorem.sentence(3),
                          righted: true,
                          score: 4)

end

20.times do |n|
  content = Faker::Lorem.sentence(10)+'?'

  question = Xmt::Test::SingleChoice.create(content: content,
                                           score: 5,
                                       category_id: category.id)


  3.times do |t|
    question.answers.create(title: Faker::Lorem.sentence(3),
                            righted: false,
                            score: 0)
  end
  question.answers.create(title: Faker::Lorem.sentence(3),
                          righted: true,
                          score: 5)
end