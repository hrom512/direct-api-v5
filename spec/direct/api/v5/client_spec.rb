require 'spec_helper'

describe Direct::API::V5::Client do
  let(:client) { described_class.new }

  describe '::new' do
    let(:settings) { { param1: 'value1', param2: 'value2' } }
    let(:settings_obj) { double('settings') }

    subject { described_class.new(settings) }

    it 'create Settings object' do
      allow(Direct::API::V5::Settings).to receive(:new).with(settings).and_return(settings_obj)
      expect(subject.settings).to eq(settings_obj)
    end
  end

  describe '#service_name' do
    let(:service_obj) { double('service_obj') }

    it 'return service object' do
      params = { client: client, service_name: :campaigns }
      allow(Direct::API::V5::Service).to receive(:new).with(params).and_return(service_obj)

      expect(client.campaigns).to eq(service_obj)
    end
  end
end
