require ('minitest/autorun')
require ('minitest/rg')
require ('pry')
require_relative('../tab')
require_relative('../guest')

class TestTab < Minitest::Test

  def setup
    @guest1 = Guest.new("Bob", 5, "Hello")
    @guest2 = Guest.new("Jim", 20, "Simple as This'")

    @tab1 = Tab.new(@guest1, 10, 200)
    @tab2 = Tab.new(@guest2, 20, 80)
  end

  def test_guest
    assert_equal("Jim", @tab2.guest.name)
  end

  def test_caraoke_spend
    assert_equal(10, @tab1.caraoke_spend)
  end

  def test_bar_spend
    assert_equal(80, @tab2.bar_spend)
  end

end
