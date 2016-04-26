require 'spec_helper'
require 'direct/api/v5/response/underscored_hash'

describe Direct::API::V5::Response::UnderscoredHash do
  let(:input_hash) do
    {
      :Id => 1,
      'Name' => 'Value',
      1 => 2,
      TextCampaign: {
        CounterIds: {
          Items: [1, 2]
        }
      }
    }
  end

  let(:underscored_hash) do
    {
      :id => 1,
      'name' => 'Value',
      1 => 2,
      text_campaign: {
        counter_ids: {
          items: [1, 2]
        }
      }
    }
  end

  subject { described_class.new(input_hash) }

  it 'works recursively' do
    expect(subject[:text_campaign][:counter_ids]).to be_a(described_class)
  end

  it 'underscore keys' do
    is_expected.to eq(underscored_hash)
  end

  it 'freeze data' do
    expect { subject[:id] = 2 }.to raise_error(RuntimeError)
    expect { subject[:new_key] = 'value' }.to raise_error(RuntimeError)
  end

  describe 'method-based reading' do
    it 'return value by key' do
      expect(subject.name).to eq('Value')
      expect(subject.text_campaign.counter_ids.items).to eq([1, 2])
    end

    it 'raise error for not existed key' do
      expect { subject.not_existed_key }.to raise_error(NoMethodError)
    end
  end

  context 'with invalid input' do
    it 'raise error' do
      expect { described_class.new('string') }.to raise_error('Invalid param')
      expect { described_class.new(123) }.to raise_error('Invalid param')
    end
  end
end
