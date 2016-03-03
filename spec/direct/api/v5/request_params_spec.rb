require 'spec_helper'

describe Direct::API::V5::RequestParams do
  let(:input_params) do
    {
      criteria: {
        :type => :text_campaign,
        :state => [:on, :off]
      },
      fields: [:id, :name, :state, :status, :status_payment],
      text_campaign_fields: [:counter_ids],
      page: {
        limit: 100,
        offset: 200
      }
    }
  end

  let(:output_params) do
    {
      SelectionCriteria: {
        Types: %w(TEXT_CAMPAIGN),
        States: %w(ON OFF)
      },
      FieldNames: %w(Id Name State Status StatusPayment),
      TextCampaignFieldNames: %w(CounterIds),
      Page: {
        Limit: 100,
        Offset: 200
      }
    }
  end

  let(:request_params) { described_class.new(input_params) }

  it 'prepare params' do
    expect(request_params.data).to eq(output_params)
  end
end
