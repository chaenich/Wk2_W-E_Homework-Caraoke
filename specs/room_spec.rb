require ('minitest/autorun')
require ('minitest/rg')
require ('pry')
require_relative('../room')
require_relative('../song')
require_relative('../guest')

require ('pry')

class TestRoom < Minitest::Test

  def setup

    @guest1 = Guest.new("Bob", 10, "Hello")
    @guest2 = Guest.new("Jim", 20, "Whats Up")
    @guest3 = Guest.new("Susan", 8, "Teenage Kicks")
    @guest4 = Guest.new("Harry", 5, "Simple as This")
    @guest5 = Guest.new("Sandra", 4, "Warhead")

    @song1 = Song.new("Teenage Kicks")
    @song2 = Song.new("Whats Up")
    @song3 = Song.new("Simple as This")

    # Room num, max num guests
    @room1 = Room.new(1, 3,
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

  def test_check_if_room_for_more__yes
    allow_more =  @room1.still_room?(@guest4)
    assert_equal(true, allow_more)
  end

  def test_check_if_room_for_more__no
    @room1.check_in_guest(@guest3)
    allow_more =  @room1.still_room?(@guest4)
    assert_equal(false, allow_more)
  end

  def test_check_in_guest__still_room
    @room1.check_in_guest(@guest3)
    assert_equal(3, @room1.guests.count)
  end

  def test_check_in_guest__no_room
    @room1.check_in_guest(@guest3)
    @room1.check_in_guest(@guest4)
    assert_equal(3, @room1.guests.count)
  end

  def test_check_out_guest
    @room1.check_out_guest(@guest1)
    assert_equal(1, @room1.guests.count)
  end

  def test_add_song
    @room1.add_song(@song3)
    assert_equal([@song1, @song2, @song3], @room1.songs)
  end

  def test_max_guests
    assert_equal(3, @room1.max_guests)
  end

  def test_entry_fee
    assert_equal(5, @room1.entry_fee)
  end

  def test_got_enough_cash__yes
    cash_ok = @room1.got_enough_cash?(@guest4)
    assert_equal(true, cash_ok)
  end

  def test_got_enough_cash__no
    cash_ok = @room1.got_enough_cash?(@guest5)
    assert_equal(false, cash_ok)
  end

  def test_check_in_guest__enough_cash
    @room1.check_in_guest(@guest4)
    assert_equal(["Bob", "Jim", "Harry"], @room1.guests.map { | guest | guest.name })
  end

  def test_check_in_guest__not_enough_cash
    @room1.check_in_guest(@guest5)
    assert_equal(["Bob", "Jim"], @room1.guests.map { | guest | guest.name })
  end

  def test_check_in_guest__combo
    # not enough cash - not in
    @room1.check_in_guest(@guest5)
    # enough cash and room - in
    @room1.check_in_guest(@guest3)
    # enough cash but no room - not in
    @room1.check_in_guest(@guest4)
    assert_equal(["Bob", "Jim", "Susan"], @room1.guests.map { | guest | guest.name })
  end

  def test_fave_song_exists
    assert_equal("Teenage Kicks", @guest3.fave_song)
  end

  def test_guest_fave_song_in_room__yes
    guest_reaction = @room1.fave_song_in_room(@guest3)
    assert_equal("WooHoo", guest_reaction)
  end

  def test_guest_fave_song_in_room__no
    guest_reaction = @room1.fave_song_in_room(@guest4)
    assert_equal("Bah", guest_reaction)
  end

end
