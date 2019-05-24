# require ('pry')

class Room

  attr_reader :room_num, :guests, :songs

  def initialize(room_num, guests, songs)
    @room_num = room_num
    @guests = guests
    @songs = songs
  end

  def check_in_guest(guest)
    @guests.push(guest)
  end

  def check_out_guest(guest)
    guests.delete(guest)
  end

  def add_song(song)
    songs.push(song)
  end

end
