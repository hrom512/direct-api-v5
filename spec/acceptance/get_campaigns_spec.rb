require 'spec_helper'

describe 'campaigns.get', type: :acceptance do
  let(:api) { make_direct_api_client }

  before do
    request_body = {
      method: 'get',
      params: {
        FieldNames: %w(Id Name State StartDate),
        TextCampaignFieldNames: %w(CounterIds RelevantKeywords),
        SelectionCriteria: {
          Types: %w(TEXT_CAMPAIGN),
          States: %w(ON SUSPENDED),
          StatusesPayment: %w(ALLOWED)
        }
      }
    }

    response_body = {
      result: {
        Campaigns: [
          { Id: 1, Name: 'Campaign 1', State: 'ON', StartDate: '2016-01-01' },
          { Id: 2, Name: 'Campaign 2', State: 'SUSPENDED', StartDate: '2016-02-01' }
        ]
      }
    }

    stub_direct_api_request(:campaigns, request_body, response_body)
  end

  subject(:response) do
    api.campaigns.get(
      fields: [:id, :name, :state, :start_date],
      text_campaign_fields: [:counter_ids, :relevant_keywords],
      criteria: { types: %w(TEXT_CAMPAIGN), states: %w(ON SUSPENDED), statuses_payment: %w(ALLOWED) }
    )
  end

  let(:campaigns) { response.result[:Campaigns] }
  let(:campaign) { campaigns[0] }

  it 'is not error' do
    expect(response.error?).to be_falsey
  end

  it 'have request_id' do
    expect(response.request_id).to eq(direct_api_request_id)
  end

  it 'have units' do
    expect(response.units.raw).to eq(direct_api_units) # '10/20828/64000'

    expect(response.units.spent).to eq(10)
    expect(response.units.available).to eq(20_828)
    expect(response.units.daily_limit).to eq(64_000)
  end

  it 'have campaigns' do
    expect(campaigns.size).to eq(2)
  end

  it 'campaign contains data' do
    expected = {
      Id: 1,
      Name: 'Campaign 1',
      State: 'ON',
      StartDate: '2016-01-01'
    }
    expect(campaign).to eq(expected)
  end
end
