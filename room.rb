require ('pry')

class Room

  attr_reader :room_num, :max_guests, :guests, :songs, :entry_fee

  def initialize(room_num, max_guests, guests, songs)
    @room_num = room_num
    @max_guests = max_guests
    @guests = guests
    @songs = songs

    # entry fee same for all rooms
    @entry_fee = 5
  end

  def check_in_guest(guest)
    @guests.push(guest) if got_enough_cash?(guest) && still_room?(guest)
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
# binding.pry
    (@songs.map { | song |  song.song_name } ).include?(guest.fave_song) ? "WooHoo" : "Bah"
  end

end
