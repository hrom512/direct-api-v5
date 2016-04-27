require 'spec_helper'
require 'direct/api/v5/response/base'

describe Direct::API::V5::Response::Base do
  let(:response_body) { 'body' }
  let(:response_headers) do
    {
      RequestId: '8695244274068608439',
      Units: '10/20828/64000'
    }
  end

  let(:response) { described_class.new(response_body, response_headers) }

  describe '#body' do
    it { expect(response.body).to eq(response_body) }
  end

  describe '#headers' do
    it { expect(response.headers).to eq(response_headers) }
  end

  describe '#request_id' do
    it { expect(response.request_id).to eq(response_headers[:RequestId]) }
  end

  describe '#units' do
    it 'return Units object' do
      expect(response.units).to be_a(Direct::API::V5::Response::Units)
      expect(response.units.raw).to eq(response_headers[:Units])
    end
  end

  describe '#error?' do
    it { expect(response.error?).to be_falsey }
  end
end
