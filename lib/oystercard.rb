require_relative 'journey'
require_relative 'journeyLog'

class Oystercard

  attr_reader :balance, :journey
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize()
    @balance = 0
    @journey = JourneyLog.new(Journey)
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
    journey.end(exit_station)
    deduct(journey.journeys.last.fare)
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
