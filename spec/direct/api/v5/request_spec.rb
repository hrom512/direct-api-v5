require 'spec_helper'

describe Direct::API::V5::Request do
  let(:client) { make_direct_api_client }

  describe '#send' do
    let(:service) { :Campaigns }
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
      Direct::API::V5::ParamsBuilder.new(params).build
    end
    let(:request_body) do
      { method: method, params: request_params }
    end
    let(:response_body) do
      { result: { Campaigns: result } }
    end

    let(:request) do
      described_class.new(
        settings: client.settings,
        service_name: service,
        api_method: method,
        params: params
      )
    end

    context 'with valid response' do
      before { stub_direct_api_request(service, request_body, response_body) }

      it 'return body and headers' do
        body, headers = request.send
        expect(body).to eq(response_body)
        expect(headers[:RequestId]).to eq(direct_api_request_id)
        expect(headers[:Units]).to eq(direct_api_units)
      end
    end

    context 'with invalid response' do
      before { stub_direct_api_request(service, request_body, 'invalid') }

      it 'raise error' do
        expect { request.send }.to raise_error(Direct::API::V5::InvalidResponseError)
      end
    end
  end
end
