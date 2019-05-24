require('minitest/autorun')
require('minitest/rg')
require_relative('../song')
# require_relative('../guest')
# require_relative('../room')

class TestSong<Minitest::Test

  def setup
    @song1 = Song.new("Teenage Kicks")
    @song2 = Song.new("Hello")
    @song3 = Song.new("Ride")
    @song4 = Song.new("Whats Up")
    @song5 = Song.new("Simple as This")
  end

  def test_song_name
    assert_equal("Ride", @song3.song_name)
  end

end
