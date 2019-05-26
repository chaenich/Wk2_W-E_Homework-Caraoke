require('minitest/autorun')
require('minitest/rg')
require_relative('../guest')


class TestGuest < Minitest::Test

  def setup
    @guest1 = Guest.new("Bob", 5, "Hello", 5)
    @guest2 = Guest.new("Jim", 20, "Simple as This", 4)
    @guest3 = Guest.new("Susan", 4, "Teenage Kicks", 9)
  end

  def test_guest_name
    assert_equal("Jim", @guest2.name)
  end

  def test_cash_available
    assert_equal(4, @guest3.cash)
  end

  def test_fave_song
    assert_equal("Hello", @guest1.fave_song)
  end

  def test_free_beer_number
    assert_equal(4, @guest2.free_beer_num)
  end

end
