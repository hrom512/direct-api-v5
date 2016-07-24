require 'spec_helper'

describe Direct::API::V5::Response::Error do
  let(:data) do
    {
      error_code: 54,
      error_string: 'No rights',
      error_detail: 'No rights to indicated client'
    }
  end

  subject { described_class.new(data) }

  describe '#code' do
    it { expect(subject.code).to eq(54) }
  end

  describe '#message' do
    it { expect(subject.message).to eq('No rights') }
  end

  describe '#details' do
    it { expect(subject.details).to eq('No rights to indicated client') }
  end

  describe '#to_h' do
    error_hash = { code: 54, message: 'No rights', details: 'No rights to indicated client' }
    it { expect(subject.to_h).to eq(error_hash) }
  end
end
