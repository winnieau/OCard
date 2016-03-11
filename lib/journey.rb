class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_accessor :entry_station, :exit_station

  def initialize
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def end(exit_station)
    @exit_station = exit_station
  end

  def fare(entry_station = false, exit_station = false)
   ((entry_station || exit_station) == false) ? PENALTY_FARE : MINIMUM_FARE
  end

end
