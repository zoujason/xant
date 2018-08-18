require 'test_helper'
require 'minitest/spec'
describe User do
  it "sssss" do
    true.must_equal true
  end

end
class CalcTest < ActiveSupport::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end



  # Fake test
  def test_fail
    c = Calc.new

    assert 2, c.add(1, 1)
    mock = MiniTest::Mock.new
    mock.expect(:select,        nil, ['INBOX'])
    mock.stub(:select).ret
    Calc.stub(:select, nil) do
      p mock.select('INBOX')
    end



  end
end