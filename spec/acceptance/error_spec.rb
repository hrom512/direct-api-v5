require 'spec_helper'

describe 'api error', :type => :acceptance do
  let(:api) { make_direct_api_client }

  before do
    request_body = {
      method: 'get',
      params: {}
    }

    response_body = {
      error: {
        error_code: 54,
        error_string: 'No rights',
        error_detail: 'No rights to indicated client'
      }
    }

    stub_direct_api_request(:campaigns, request_body, response_body)
  end

  subject(:response) { api.campaigns.get }

  it 'return error' do
    expect(response.error?).to be_truthy

    expect(response.code).to eq(54)
    expect(response.message).to eq('No rights')
    expect(response.details).to eq('No rights to indicated client')
  end
end
