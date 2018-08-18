module Xmt::Test::QuestionsHelper
  def type_title(obj)
    if obj.instance_of?(Xmt::Test::MultipleChoice)
      return "多选题"
    elsif obj.instance_of?(Xmt::Test::BinaryChoice)
      return "判断题"
    elsif obj.instance_of?(Xmt::Test::SingleChoice)
      return "单选题"
    else
      return ""
    end
  end
end
