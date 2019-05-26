require ('minitest/autorun')
require ('minitest/rg')
# require ('pry')
require_relative('../room')
require_relative('../song')
require_relative('../guest')
require_relative('../tab')

require ('pry')

class TestRoom < Minitest::Test

  def setup
    # xx, cash, xx, free_beer_num
    @guest1 = Guest.new("Bob", 10, "Hello", 6)
    @guest2 = Guest.new("Jim", 20, "Whats Up", 8)
    @guest3 = Guest.new("Susan", 8, "Teenage Kicks", 6)
    @guest4 = Guest.new("Harry", 5, "Simple as This", 9)
    @guest5 = Guest.new("Sandra", 4, "Warhead", 1)

    @song1 = Song.new("Teenage Kicks")
    @song2 = Song.new("Whats Up")
    @song3 = Song.new("Simple as This")

    # xx, caraoke spend, bar spend
    @tab1 = Tab.new(@guest1, 30, 200)
    @tab2 = Tab.new(@guest2, 20, 80)

    # Room num, max num guests
    @room1 = Room.new(1, 3,
    [@guest1, @guest2],
    [@song1, @song2],
    [@tab1, @tab2])

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

  def test_fave_song_for_guest
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

  def test_add_tab_to_room
    @tab3 = Tab.new(@guest3, 10, 0)
    @room1.add_tab_to_room(@tab3)
    assert_equal([@tab1, @tab2, @tab3], @room1.tabs)
  end

  def test_caraoke_tab_transaction__£5_entry_fee_fixed
  # guest3 cash down by 5; tab3 caraoke_spend up by 5
    @room1.check_in_guest(@guest3)
    @tab3 = Tab.new(@guest3, 10, 0)
    @room1.add_tab_to_room(@tab3)
    @room1.perform_caraoke_tab_accounting(@guest3, @tab3)
    assert_equal(3, @guest3.cash)
    assert_equal(15, @tab3.caraoke_spend)
  end

  def test_bar_tab_transaction__£3_bar_bill
    @room1.perform_bar_tab_accounting(@guest2, @tab2, 3)
    assert_equal(17, @guest2.cash)
    assert_equal(83, @tab2.bar_spend)
  end

  # if random number draw matches cust num -> free beer
  def test_free_beer__you_win
    good_day = @room1.have_i_won_free_beer?(@guest2)
    assert_equal(true, good_day)
  end

  def test_free_beer__not_this_time
    good_day = @room1.have_i_won_free_beer?(@guest3)
    assert_equal(false, good_day)
  end

end
