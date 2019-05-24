require('minitest/autorun')
require('minitest/rg')
require_relative('../guest')
# require_relative('../room')
# require_relative('../song')

class TestGuest < Minitest::Test

  def setup
    @guest1 = Guest.new("Bob")
    @guest2 = Guest.new("Jim")
    @guest3 = Guest.new("Susan")
    @guest4 = Guest.new("Adam")
    @guest5 = Guest.new("Helen")
  end

  def test_guest_name
    assert_equal("Jim", @guest2.name)
  end
end
