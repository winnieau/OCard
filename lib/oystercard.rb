require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey
  # attr_accessor :journeys
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize()
    @balance = 0
    @journey = Journey.new
    # @journeys = {}
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Top up in order to meet minimum balance of #{MINIMUM_BALANCE}" if balance < MINIMUM_BALANCE
    journey.start(entry_station)
  end

  def touch_out(exit_station)
    deduct(MINIMUM_CHARGE)
    journey.journeys[journey.entry_station] = exit_station
  end

  def in_journey?
    journey.in_journey?
  end

  def journeys
    journey.journeys
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
