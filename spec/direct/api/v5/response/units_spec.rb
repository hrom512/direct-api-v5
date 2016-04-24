require 'spec_helper'
require 'direct/api/v5/response/units'

describe Direct::API::V5::Response::Units do
  let(:raw_units) { '10/20828/64000' }

  let(:units) { described_class.new(raw_units) }

  describe '#raw' do
    it { expect(units.raw).to eq(raw_units) }
  end

  describe '#spent' do
    it { expect(units.spent).to eq(10) }
  end

  describe '#available' do
    it { expect(units.available).to eq(20_828) }
  end

  describe '#daily_limit' do
    it { expect(units.daily_limit).to eq(64_000) }
  end

  context 'with invalid data' do
    let(:units) { described_class.new('invalid/data') }

    it { expect(units.spent).to be_nil }
    it { expect(units.available).to be_nil }
    it { expect(units.daily_limit).to be_nil }
  end
end
