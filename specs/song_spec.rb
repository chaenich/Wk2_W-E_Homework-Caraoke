require('minitest/autorun')
require('minitest/rg')
require_relative('../song')
# require_relative('../guest')
# require_relative('../room')

class TestSong<Minitest::Test

  def setup
    @song1 = Song.new("Teenage Kicks")
    @song2 = Song.new("Whats Up")
    @song3 = Song.new("Simple as This")
  end

  def test_song_name
    assert_equal("Simple as This", @song3.song_name)
  end

end
