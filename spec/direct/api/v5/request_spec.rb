require 'spec_helper'

describe Direct::API::V5::Request do
  let(:client) { make_direct_api_client }
  let(:request) { described_class.new(client.settings) }

  describe '#send' do
    let(:service) { :Campaigns }
    let(:method) { :get }
    let(:params) do
      {
        FieldNames: %w(Id Name),
        SelectionCriteria: { Types: %w(TEXT_CAMPAIGN) }
      }
    end
    let(:result) do
      [
        { Id: 1, Name: 'Campaign 1' },
        { Id: 2, Name: 'Campaign 2' }
      ]
    end

    let(:request_body) do
      {
        method: method,
        params: params
      }
    end
    let(:response_body) do
      {
        result: {
          Campaigns: result
        }
      }
    end

    before { stub_direct_api_request(service, request_body, response_body) }

    subject { request.send(service, method, params) }

    it 'send request' do
      is_expected.to eq(result)
    end
  end
end
