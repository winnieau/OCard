class Oystercard

  attr_reader :balance
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in
    fail "Top up in order to meet minimum balance of #{MINIMUM_BALANCE}" if balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_CHARGE)
  end

  def in_journey?
    @in_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
