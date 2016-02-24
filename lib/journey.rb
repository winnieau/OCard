class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :journeys
  attr_accessor :entry_station, :exit_station

  def initialize
    @journeys = {}
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def in_journey?
    journeys.length > 0 ?  @journeys[entry_station] == nil : false
  end

  def start(entry_station)
    @entry_station = entry_station
    journeys[entry_station] = nil
  end

  def end(exit_station)
    @exit_station = exit_station
    journeys[entry_station] = exit_station
  end

  def fare (entry_station = false, exit_station = false)
    if ((entry_station || exit_station) == false)
      return PENALTY_FARE
    else
      MINIMUM_FARE
    end
  end

end
