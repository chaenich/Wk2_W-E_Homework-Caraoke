# require ('pry')

class Room

  attr_reader :room_num, :max_guests, :guests, :songs, :tabs, :entry_fee

  def initialize(room_num, max_guests, guests, songs, tabs)
    @room_num = room_num
    @max_guests = max_guests
    @guests = guests
    @songs = songs
    @tabs = tabs

    # entry fee same for all rooms
    @entry_fee = 5
  end

  def check_in_guest(guest)
    if got_enough_cash?(guest) && still_room?(guest)
      @guests.push(guest)
    end
  end

  def check_out_guest(guest)
    @guests.delete(guest)
  end

  def add_song(song)
    @songs.push(song)
  end

  def still_room?(guest)
    return @guests.count < @max_guests
  end

  def got_enough_cash?(guest)
    return guest.cash >= @entry_fee
  end

  def fave_song_in_room(guest)
    (@songs.map { | song |  song.song_name } ).include?(guest.fave_song) ? "WooHoo" : "Bah"
  end

  def add_tab_to_room(tab)
    @tabs.push(tab)
  end

  def perform_caraoke_tab_accounting(guest, tab)
    guest.cash -= @entry_fee
    tab.caraoke_spend += @entry_fee
  end

  def perform_bar_tab_accounting(guest, tab, amt_spent)
    guest.cash -= amt_spent
    tab.bar_spend += amt_spent
  end

  def have_i_won_free_beer?(guest)
    srand 2 # random number for seed -> 8 - testing
    draw_num = rand(10)
    return draw_num == guest.free_beer_num
  end

end
