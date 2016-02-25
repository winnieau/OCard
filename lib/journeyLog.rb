class JourneyLog

  attr_reader :journeys
  attr_accessor :entry_station, :exit_station

  def initialize
    @journeys = {}
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def start(entry_station)
    @entry_station = entry_station
    journeys[entry_station] = nil
  end

  def in_journey?
    journeys.length > 0 ?  @journeys[entry_station] == nil : false
  end

end
