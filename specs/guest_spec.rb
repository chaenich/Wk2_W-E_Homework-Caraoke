require('minitest/autorun')
require('minitest/rg')
require_relative('../guest')


class TestGuest < Minitest::Test

  def setup
    @guest1 = Guest.new("Bob", 5, "Hello")
    @guest2 = Guest.new("Jim", 20, "Simple as This'")
    @guest3 = Guest.new("Susan", 4, "Teenage Kicks")
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
end
