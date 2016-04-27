require 'spec_helper'

describe Direct::API::V5::Response do
  describe '::build' do
    let(:response_type) { double('response_type') }
    let(:headers) { {} }

    subject { described_class.build(response_type, body, headers) }

    context 'without errors' do
      let(:body) do
        {
          result: {
            Campaigns: []
          }
        }
      end

      let(:response) { double('response') }

      before do
        allow(response_type).to receive(:new).with(body, headers).and_return(response)
      end

      it 'build response' do
        is_expected.to eq(response)
      end
    end

    context 'with errors' do
      let(:body) do
        {
          error: {
            error_code: 54,
            error_string: 'No rights',
            error_detail: 'No rights to indicated client'
          }
        }
      end

      let(:error_response) { double('error_response') }

      before do
        allow(Direct::API::V5::Response::Error).to receive(:new).with(body, headers).and_return(error_response)
      end

      it 'build response' do
        is_expected.to eq(error_response)
      end
    end
  end
end
