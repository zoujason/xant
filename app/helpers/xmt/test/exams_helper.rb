module Xmt::Test::ExamsHelper
  def get_mode(exam)
    case exam.class.to_s
      when "Xmt::Test::FixExam"
        Xmt::Core::Dict.dict("Xmt::Test::FixExam",'exam_mode').title
      when "Xmt::Test::RandExam"
        Xmt::Core::Dict.dict("Xmt::Test::RandExam",'exam_mode').title
      when "Xmt::Test::CompEaxm"
        Xmt::Core::Dict.dict("Xmt::Test::CompEaxm",'exam_mode').title
      else
        ""
    end

  end

  def edit_exam_path(obj,channel)
    case obj.class.to_s
      when "Xmt::Test::FixExam"
        edit_xmt_test_fix_exam_path(obj,channel_id:channel)
      when "Xmt::Test::RandExam"
        edit_xmt_test_rand_exam_path(obj,channel_id:channel)
      when "Xmt::Test::CompEaxm"
        edit_xmt_test_comp_exam_path(obj,channel_id:channel)
      else
        edit_xmt_test_exams_path(obj,channel_id:channel)
    end
  end
end
