module Xmt::Test::CategoriesHelper

  def all_category_options
    Xmt::Test::Category.all.collect { |c| [ c.ancestors_and_self_name_format, c.id ] }
  end

  def category_options(catgory)
    catgory.descendants_and_self.collect {
            |c|  [c.ancestors_and_self_name_format, c.id]
    }
  end

end
