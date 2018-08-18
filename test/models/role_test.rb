require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  def setup
    @role = build(:role)
  end

   test "the truth" do
     assert @role
   end
end
