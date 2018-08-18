module Xmt::Test::PapersHelper
  def question_format(id,typ)
    question = Xmt::Test::Question.find_by(id:id)
    if question
      item = "<p>#{question.content}<span>(分数:#{question.score})</span></p><ol type='A' >"
      question.answers.each_with_index do |answer,ind|
        if typ == 'multiple'
          item += "<li><input type='checkbox' class='answers' name='results[#{id}][answer_ids][]' value='#{answer.id}' /><span class='answers_title'>#{answer.title}</span></li>"
        else
          item += "<li><input type='radio' class='answers' name='results[#{id}][answer_ids][]' value='#{answer.id}' onclick='single_choice($(this))'/><span class='answers_title'>#{answer.title}</span></li>"
        end

      end
      item +="</ol>"
    end

  end

  def exam_rules(exam)
    type_rules = exam.type_rules
    html = ''
    type_rules.each do |rule|
      case rule.question_type
        when 'Xmt::Test::SingleChoice'
          html += "<input type='hidden' name='exam_single' value='#{rule.question_size}' />"
        when 'Xmt::Test::MultipleChoice'
          html += "<input type='hidden' name='exam_multiple' value='#{rule.question_size}' />"
        when 'Xmt::Test::BinaryChoice'
          html += "<input type='hidden' name='exam_binary' value='#{rule.question_size}' />"
      end

    end
    html
  end
end
