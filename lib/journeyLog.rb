class JourneyLog

  attr_reader :journeys, :journey, :journey_klass

  def initialize(journey_klass)
    @journeys = []
    @journey_klass = journey_klass
    @journey = journey_klass.new
  end

  def start(entry_station)
    log_journey unless in_journey?
    new_journey
    journey.start(entry_station)
  end

  def in_journey?
    journey.entry_station != nil
    # journeys.length > 0 ?  @journeys[entry_station] == nil : false
  end

  def log_journey
    @journeys << journey
  end

  def new_journey
    @journey = journey_klass.new
  end

  private

  def current_journey
    @current_journey || journey_klass.new
  end

end
