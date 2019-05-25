require('minitest/autorun')
require('minitest/rg')
require_relative('../guest')
# require_relative('../room')
# require_relative('../song')

class TestGuest < Minitest::Test

  def setup
    @guest1 = Guest.new("Bob", 5)
    @guest2 = Guest.new("Jim", 20)
    @guest3 = Guest.new("Susan", 4)
  end

  def test_guest_name
    assert_equal("Jim", @guest2.name)
  end

  def test_cash_available
    assert_equal(4, @guest3.cash)
  end

end
