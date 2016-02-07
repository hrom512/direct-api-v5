require 'spec_helper'

describe 'Campaigns', :type => :acceptance do
  let(:api) { make_direct_api_client }

  describe '.get' do
    let(:fields) { [:id, :name, :start_date] }
    let(:text_campaign_fields) { [:counter_ids, :relevant_keywords] }
    let(:conditions) do
      { :type => :text_campaign, :state => [:on, :suspended], :status_payment => :allowed }
    end
    let(:campaigns) do
      [
        { id: 1, name: 'Campaign 1', start_date: Date.parse('2015-01-01') },
        { id: 2, name: 'Campaign 2', start_date: Date.parse('2015-02-01') }
      ]
    end

    let(:field_names) { %w(Id Name StartDate) }
    let(:text_campaign_field_names) { %w([CounterIds RelevantKeywords) }
    let(:selection_criteria) do
      { Types: %w(TEXT_CAMPAIGN), States: %w(ON SUSPENDED), StatusesPayment: %w(ALLOWED) }
    end
    let(:response_objects) do
      [
        { Id: 1, Name: 'Campaign 1', StartDate: '2015-01-01' },
        { Id: 2, Name: 'Campaign 2', StartDate: '2015-02-01' }
      ]
    end

    let(:request_body) do
      {
        method: 'get',
        params: {
          FieldNames: field_names,
          TextCampaignFieldNames: text_campaign_field_names,
          SelectionCriteria: selection_criteria
        }
      }
    end
    let(:response_body) do
      { result: { Campaigns: response_objects } }
    end

    before do
      stub_direct_api_request(:campaigns, request_body, response_body)
    end

    subject do
      api.campaigns
         .select(*fields)
         .select(text_campaign: text_campaign_fields)
         .where(conditions)
         .get
    end

    it 'return campaigns' do
      is_expected.to eq(campaigns)
    end
  end
end
