class Tab

  attr_reader :guest
  attr_accessor :caraoke_spend, :bar_spend

  def initialize(guest, caraoke_spend, bar_spend)
    @guest = guest
    @caraoke_spend = caraoke_spend
    @bar_spend = bar_spend
  end

end
