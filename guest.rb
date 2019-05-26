class Guest

  attr_reader :name, :fave_song, :free_beer_num
  attr_accessor :cash

  def initialize(name, cash, fave_song, free_beer_num)
    @name = name
    @cash = cash
    @fave_song = fave_song
    @free_beer_num = free_beer_num
  end

end
