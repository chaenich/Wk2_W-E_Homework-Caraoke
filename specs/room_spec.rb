require ('minitest/autorun')
require ('minitest/rg')
require ('pry')
require_relative('../room')
require_relative('../song')
require_relative('../guest')

require ('pry')

class TestRoom < Minitest::Test

  def setup

    @guest1 = Guest.new("Bob", 5)
    @guest2 = Guest.new("Jim", 20)
    @guest3 = Guest.new("Susan", 4)

    @song1 = Song.new("Teenage Kicks")
    @song2 = Song.new("Whats Up")
    @song3 = Song.new("Simple as This")

    @room1 = Room.new(1, 7,
    [@guest1, @guest2],
    [@song1, @song2])

  end

  def test_room_number
    assert_equal(1, @room1.room_num)
  end

  def test_people_count_in_room
    assert_equal(2, @room1.guests.count)
  end

  def test_guest_names_in_room
    assert_equal(["Bob", "Jim"], @room1.guests.map { | guest | guest.name } )
  end

  def test_song_count_in_room
    assert_equal(2, @room1.songs.count)
  end

  def test_songs_in_room
    assert_equal(["Teenage Kicks", "Whats Up"], @room1.songs.map { | song | song.song_name } )
  end

  def test_check_in_guest
    @room1.check_in_guest(@guest3)
    assert_equal([@guest1, @guest2, @guest3], @room1.guests)
  end

  def test_check_out_guest
    @room1.check_out_guest(@guest1)
    assert_equal([@guest2], @room1.guests)
  end

  def test_add_song
    @room1.add_song(@song3)
    assert_equal([@song1, @song2, @song3], @room1.songs)
  end

  def test_max_guests__room1
    assert_equal(7, @room1.max_guests)
  end

  def test_entry_fee__room1
    assert_equal(5, @room1.entry_fee)
  end

end
