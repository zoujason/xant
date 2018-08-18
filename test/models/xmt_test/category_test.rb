require 'test_helper'

class XmtTest::CategoryTest < ActiveSupport::TestCase

  # test "the truth" do
  #   assert true
  # end
  def setup
    @category = create(:category_one)
  end

  test "category attributes must not be empty" do
    category = Xmt::Test::Category.new
    assert category.invalid?
    assert category.errors[:title].any?
  end

  test "category title must less than 50 characters" do
    category = Xmt::Test::Category.new
    category.title = 'a'*51
    assert category.invalid?
    assert category.errors[:title].any?

    category.title = 'a'*49
    assert category.valid?
  end

  test "ancestors_and_self_name_format" do
    category_son = Xmt::Test::Category.create({title: "one_son", parent_id: @category.id})
    name = category_son.ancestors_and_self_name_format
    assert_equal "parent>>one_son", name
  end

  test "nested_set_options" do
    son = Xmt::Test::Category.create({title: "son", parent_id: @category.id})
    assert_equal ["#{@category.title}",BSON::ObjectId("#{@category.id}")], @category.nested_set_options[0]
    assert_equal ["#{son.ancestors_and_self_name_format}",BSON::ObjectId("#{son.id}")], @category.nested_set_options[1]
  end

end
