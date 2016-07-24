require 'spec_helper'

describe Direct::API::V5::Response do
  let(:headers) do
    {
      RequestId: '123',
      Units: '10/100/200'
    }
  end
  let(:body) do
    {
      result: {
        Campaigns: []
      }
    }
  end
  let(:error_body) do
    {
      error: {
        error_code: 54,
        error_string: 'No rights',
        error_detail: 'No rights to indicated client'
      }
    }
  end

  let(:response) { described_class.new(body, headers) }
  let(:error_response) { described_class.new(error_body, headers) }

  describe '#result' do
    it 'return data from result key' do
      expect(response.result).to eq(Campaigns: [])
      expect(error_response.result).to be_nil
    end
  end

  describe '#request_id' do
    it 'return data from headers' do
      expect(response.request_id).to eq('123')
      expect(error_response.request_id).to eq('123')
    end
  end

  describe '#units' do
    it 'return Units object' do
      expect(response.units).to be_a(Direct::API::V5::Response::Units)
      expect(response.units.raw).to eq('10/100/200')
    end
  end

  describe '#error?' do
    it 'check error key' do
      expect(response.error?).to eq(false)
      expect(error_response.error?).to eq(true)
    end
  end

  describe '#error' do
    it 'return Error object' do
      expect(response.error).to be_nil

      expect(error_response.error).to be_a(Direct::API::V5::Response::Error)
      expect(error_response.error.code).to eq(54)
    end
  end
end
