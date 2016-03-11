require 'journey'

describe Journey do

  let(:entry_station) {double :entry_station, zone: 1}
  let(:exit_station) {double :exit_station, zone: 2}


  it 'should return minimum fare for completed journey' do
    minimum_fare = Journey::MINIMUM_FARE
    subject.start(entry_station)
    subject.end(entry_station)
    expect(subject.fare).to eq(minimum_fare)
  end

  it 'should give penalty fare if entry_station or exit_station is missing' do
    penalty_fare = Journey::PENALTY_FARE
    expect(subject.fare).to eq(penalty_fare)
  end

  it 'calculates fare as £2 when travelling between 2 zones' do
    subject.start(entry_station)
    subject.end(exit_station)
    expect(subject.fare).to eq(2)
  end

end
