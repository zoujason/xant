module Poll
  class Quiz
    include Mongoid::Document
    field :name, type: String
    field :seq, type: Integer
  end

  class QuizController < Xmt::AddonBaseController
    def display
      @b = Quiz.find_or_create_by(name:'widget')
      render template: "poll/display"
      #render text: 'ss'
    end
  end
end

