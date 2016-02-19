require 'oystercard'

describe Oystercard do
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

  it {is_expected.to respond_to(:deduct).with(1).argument}

  it 'has a balance that can be decreased' do
    subject.top_up(1)
    subject.deduct(1)
    expect(subject.balance).to eq(0)
  end

  it {is_expected.to respond_to(:touch_in)}
  it {is_expected.to respond_to(:touch_out)}
  it {is_expected.to respond_to(:in_journey?)}

  it 'initial status is not in journey' do
    expect(subject).not_to be_in_journey
  end

  it 'can be touched in' do
    minimum_balance = Oystercard::MINIMUM_BALANCE
    subject.top_up(minimum_balance)
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'can be touched out' do
    minimum_balance = Oystercard::MINIMUM_BALANCE
    subject.top_up(minimum_balance)
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it 'must have a minimum balance to make journey ' do
    minimum_balance = Oystercard::MINIMUM_BALANCE
    expect {subject.touch_in}.to raise_error "Top up in order to meet minimum balance of #{minimum_balance}"
  end

end
