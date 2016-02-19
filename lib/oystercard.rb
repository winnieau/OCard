class Oystercard

  attr_reader :balance
  attr_accessor :journeys
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @journeys = {}
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Top up in order to meet minimum balance of #{MINIMUM_BALANCE}" if balance < MINIMUM_BALANCE
    @key = entry_station
    @journeys[@key] = nil
  end

  def touch_out(exit_station)
    deduct(MINIMUM_CHARGE)
    @journeys[@key] = exit_station
  end

  def in_journey?
    @journeys.length > 0 ?  @journeys[@key] == nil : false
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
