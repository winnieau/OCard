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
end
