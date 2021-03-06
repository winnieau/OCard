require 'oystercard'


describe Oystercard do
  let(:entry_station) {double :entry_station, zone: 1}
  let(:exit_station) {double :exit_station, zone: 2}
  let(:entry_station2) {double :entry_station2, zone: 1}

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it {is_expected.to respond_to(:top_up).with(1).argument}

  it 'has a balance that can be increased' do
    subject.top_up(1)
    expect(subject.balance).to eq(1)
  end

  it 'has a maximum balance of £90' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
    expect {subject.top_up(1)}.to raise_error "Maximum balance of #{maximum_balance} exceeded"
  end

  it {is_expected.to respond_to(:touch_in).with(1).argument}
  it {is_expected.to respond_to(:touch_out).with(1).argument}


  it 'can be touched in' do
    minimum_balance = Oystercard::MINIMUM_BALANCE
    subject.top_up(minimum_balance)
    subject.touch_in(entry_station)
    expect(subject).to be_in_journey
  end

  it 'can be touched out' do
    minimum_balance = Oystercard::MINIMUM_BALANCE
    subject.top_up(minimum_balance)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject).not_to be_in_journey
  end

  it 'must have a minimum balance to make journey ' do
    minimum_balance = Oystercard::MINIMUM_BALANCE
    expect {subject.touch_in(entry_station)}.to raise_error "Top up in order to meet minimum balance of #{minimum_balance}"
  end

  it 'expect to deduct balance when touching out' do
    minimum_charge = Oystercard::MINIMUM_CHARGE
    subject.top_up(minimum_charge)
    subject.touch_in(entry_station)
    expect {subject.touch_out(exit_station)}.to change{subject.balance}.by(-minimum_charge-1)
  end

  it 'adds one journey when user has touched in and out' do
    minimum_balance = Oystercard::MINIMUM_BALANCE
    subject.top_up(minimum_balance)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys[0]).to be_a Journey
  end

  it 'Acknowledges when touched out' do
    minimum_balance = Oystercard::MINIMUM_BALANCE
    subject.top_up(minimum_balance)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys[0].entry_station).not_to eq(nil)
  end

  it 'remembers the location where the user first touched in' do
    minimum_balance = Oystercard::MINIMUM_BALANCE
    subject.top_up(minimum_balance)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys[0].entry_station).to eq entry_station
  end

  it 'should should charge £2 if travelling between 2 zones' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.balance).to eq (maximum_balance-2)
  end

  it 'calculates fare as £1 when travelling inside same zone' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
    subject.touch_in(entry_station)
    subject.touch_out(entry_station2)
    expect(subject.balance).to eq (maximum_balance-1)
  end

end
