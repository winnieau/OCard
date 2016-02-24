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

end
