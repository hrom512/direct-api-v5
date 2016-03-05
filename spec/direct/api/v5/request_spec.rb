require 'spec_helper'

describe Direct::API::V5::Request do
  let(:client) { make_direct_api_client }

  describe '#send' do
    let(:service) { :campaigns }
    let(:method) { :get }
    let(:params) do
      {
        field_names: [:id, :name],
        selection_criteria: { types: %w(TEXT_CAMPAIGN) }
      }
    end
    let(:result) do
      [
        { Id: 1, Name: 'Campaign 1' },
        { Id: 2, Name: 'Campaign 2' }
      ]
    end

    let(:request_params) do
      Direct::API::V5::Request::ParamsBuilder.build(params)
    end
    let(:request_body) do
      { method: method, params: request_params }
    end
    let(:response_body) do
      { result: { Campaigns: result } }
    end

    before { stub_direct_api_request(service, request_body, response_body) }

    subject { described_class.send(client.settings, service, method, params) }

    it 'send request' do
      is_expected.to eq(result)
    end
  end
end
