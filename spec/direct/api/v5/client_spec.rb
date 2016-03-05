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

  describe '::service_name' do
    module Direct::API::V5::Services
      class CustomService
        def initialize(_client)
        end
      end
    end

    let(:service_class) { Direct::API::V5::Services::CustomService }
    let(:service_obj) { double('custom_service') }

    subject { client.custom_service }

    it 'return service object' do
      allow(service_class).to receive(:new).with(client).and_return(service_obj)
      is_expected.to eq(service_obj)
    end
  end
end
