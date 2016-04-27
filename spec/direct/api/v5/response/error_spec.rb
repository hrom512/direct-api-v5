require 'spec_helper'
require 'direct/api/v5/response/error'

describe Direct::API::V5::Response::Error do
  let(:body) do
    {
      error: {
        error_code: 54,
        error_string: 'No rights',
        error_detail: 'No rights to indicated client'
      }
    }
  end
  let(:headers) do
    {}
  end

  subject(:response) { described_class.new(body, headers) }

  describe '#error?' do
    it { expect(response.error?).to be_truthy }
  end

  describe '#code' do
    it { expect(response.code).to eq(54) }
  end

  describe '#message' do
    it { expect(response.message).to eq('No rights') }
  end

  describe '#details' do
    it { expect(response.details).to eq('No rights to indicated client') }
  end

  describe '#to_h' do
    error_hash = { code: 54, message: 'No rights', details: 'No rights to indicated client' }
    it { expect(response.to_h).to eq(error_hash) }
  end
end
