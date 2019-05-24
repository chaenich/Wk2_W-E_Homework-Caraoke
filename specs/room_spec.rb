require ('minitest/autorun')
require ('minitest/rg')
require ('pry')
require_relative('../room')
require_relative('../song')
require_relative('../guest')

class TestRoom < Minitest::Test

  def setup
    @song1 = Song.new("Teenage Kicks")
    @song2 = Song.new("Hello")
    @song3 = Song.new("Ride")
    @song4 = Song.new("Whats Up")
    @song5 = Song.new("Simple as This")
    @song6 = Song.new("BEST song ever!")

    @guest1 = Guest.new("Bob")
    @guest2 = Guest.new("Jim")
    @guest3 = Guest.new("Susan")
    @guest4 = Guest.new("Adam")
    @guest5 = Guest.new("Helen")

    @room1 = Room.new(1,
    [@guest1, @guest3],
    [@song1, @song2, @song5])

    @room2 = Room.new(2,
    [@guest2, @guest4],
    [@song1, @song2, @song3, @song4])
  end

  def test_room_number
    assert_equal(2, @room2.room_num)
  end

  def test_people_count_in_room__2
    assert_equal(2, @room2.guests.count)
  end

  def test_people_names_in_room__1
    assert_equal(["Bob", "Susan"], @room1.guests.map { | guest | guest.name } )
  end

  def test_song_count_in_room__1
    assert_equal(3, @room1.songs.count)
  end

  def test_songs_in_room__2
    assert_equal(["Teenage Kicks", "Hello", "Ride", "Whats Up"], @room2.songs.map { | song | song.song_name } )
  end

  def test_check_in_guest__room1
    @room1.check_in_guest(@guest5)
    assert_equal([@guest1, @guest3, @guest5], @room1.guests)
  end

  def test_check_out_guest__room2
    @room2.check_out_guest(@guest4)
    assert_equal([@guest2], @room2.guests)
  end

  def test_add_song__room1
    @room1.add_song(@song6)
    assert_equal([@song1, @song2, @song5, @song6], @room1.songs)
  end

end
