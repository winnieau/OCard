require 'journeyLog'

describe JourneyLog do

  subject {described_class.new(journey_klass)}

  let(:journey) {double :journey, entry_station: nil, start: nil, exit_station: nil, end: nil}
  let(:entry_station) {double :entry_station, zone: 1}
  let(:exit_station) {double :exit_station, zone: 2}
  let(:journey_klass) {double :journey_klass, new: journey}


  it {is_expected.to respond_to(:in_journey?)}

  it 'has a default of no journeys made' do
    expect(subject.journeys).to be_empty
  end

  it 'initial status is not in journey' do
    expect(subject).not_to be_in_journey
  end

  it 'can start a journey' do
    subject.start(entry_station)
    allow(journey).to receive(:entry_station).and_return('camden')
    expect(subject).to be_in_journey
  end


  it 'can log a journey' do
    subject.start(entry_station)
    allow(journey).to receive(:entry_station).and_return('camden')
    subject.end(exit_station)
    allow(journey).to receive(:exit_station).and_return('euston')
    expect(subject.journeys).to include(journey)
  end


end
