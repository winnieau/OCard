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

  def fare
   ((entry_station || exit_station) == nil) ? PENALTY_FARE : calculate_fare(entry_station, exit_station)
  end

  def calculate_fare(entry_station, exit_station)
    MINIMUM_FARE + (entry_station.zone - exit_station.zone).abs
  end

end
