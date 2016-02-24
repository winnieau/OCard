require 'journey'

describe Journey do

  it {is_expected.to respond_to(:in_journey?)}

  it 'has a default of no journeys made' do
    expect(subject.journeys).to be_empty
  end

  it 'initial status is not in journey' do
    expect(subject).not_to be_in_journey
  end

  it 'can start a journey' do
    subject.start("station")
    expect(subject).to be_in_journey
  end

  it 'can end a journey' do
    subject.end("station")
    expect(subject).not_to be_in_journey
  end

  it 'should return minimum fare for completed journey' do
    minimum_fare = Journey::MINIMUM_FARE
    expect(subject.fare("entry", "exit")).to eq(minimum_fare)
  end

  it 'should give penalty fare if entry_station or exit_station is missing' do
    penalty_fare = Journey::PENALTY_FARE
    expect(subject.fare()).to eq(penalty_fare)
  end

end
