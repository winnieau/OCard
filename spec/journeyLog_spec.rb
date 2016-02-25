require 'journeyLog'

describe JourneyLog do

  let(:entry_station) {double :entry_station, zone: 1}
  let(:exit_station) {double :exit_station, zone: 2}

  it {is_expected.to respond_to(:in_journey?)}

  it 'can start a journey' do
    subject.start(entry_station)
    expect(subject).to be_in_journey
  end

end
