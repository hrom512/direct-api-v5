require 'spec_helper'

describe Direct::API::V5::ParamsBuilder do
  let(:input_params) do
    {
      selection_criteria: {
        types: %w(TEXT_CAMPAIGN),
        states: %w(ON OFF)
      },
      field_names: [:id, :name, :state, :status, :status_payment],
      text_campaign_field_names: [:counter_ids],
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
      FieldNames: [:Id, :Name, :State, :Status, :StatusPayment],
      TextCampaignFieldNames: [:CounterIds],
      Page: {
        Limit: 100,
        Offset: 200
      }
    }
  end

  subject { described_class.new(input_params).build }

  it 'prepare params' do
    is_expected.to eq(output_params)
  end
end
