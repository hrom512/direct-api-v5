require 'spec_helper'

describe 'campaigns.add', :type => :acceptance do
  let(:api) { make_direct_api_client }

  before do
    request_body = {
      method: 'add',
      params: [
        { Name: 'Campaign 1' },
        { Name: 'Campaign 2' },
        { Name: 'Campaign 3' },
        { Name: 'Campaign 4' }
      ]
    }

    response_body = {
      result: {
        Campaigns: [
          { Id: 1 },
          { Id: 2, Warnings: [], Errors: [] },
          { Id: 3, Warnings: [{ Code: 1, Message: 'Warning message', Details: 'Warning description' }] },
          { Errors: [{ Code: 2, Message: 'Error message', Details: 'Error description' }] }
        ]
      }
    }

    stub_direct_api_request(:campaigns, request_body, response_body)
  end

  subject(:response) do
    campaigns_data = [
      { name: 'Campaign 1' },
      { name: 'Campaign 2' },
      { name: 'Campaign 3' },
      { name: 'Campaign 4' }
    ]
    api.campaigns.add(campaigns_data)
  end

  it 'is not error' do
    expect(response.error?).to be_falsey
  end

  context 'without errors and warnings' do
    subject(:campaign) { response[0] }

    it 'have id' do
      expect(campaign.id).to eq(1)
    end

    it 'not contain errors and warnings' do
      expect(campaign.errors?).to be_falsey
      expect(campaign.warnings?).to be_falsey
    end
  end

  context 'with blank errors and warnings' do
    subject(:campaign) { response[1] }

    it 'have id' do
      expect(campaign.id).to eq(2)
    end

    it 'not contain errors and warnings' do
      expect(campaign.errors?).to be_falsey
      expect(campaign.warnings?).to be_falsey
    end
  end

  context 'with warnings' do
    subject(:campaign) { response[2] }
    let(:warning) { campaign.warnings[0] }

    it 'have id' do
      expect(campaign.id).to eq(3)
    end

    it 'contain warnings' do
      expect(campaign.warnings?).to be_truthy

      expect(warning.code).to eq(1)
      expect(warning.message).to eq('Warning message')
      expect(warning.details).to eq('Warning description')
    end

    it 'not contain errors' do
      expect(campaign.errors?).to be_falsey
    end
  end

  context 'with errors' do
    subject(:campaign) { response[3] }
    let(:error) { campaign.errors[0] }

    it 'not have id' do
      expect(campaign[:id]).to be_nil
    end

    it 'not contain warnings' do
      expect(campaign.warnings?).to be_falsey
    end

    it 'contain errors' do
      expect(campaign.errors?).to be_truthy

      expect(error.code).to eq(2)
      expect(error.message).to eq('Error message')
      expect(error.details).to eq('Error description')
    end
  end
end
