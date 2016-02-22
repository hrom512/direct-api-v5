require 'spec_helper'

describe Direct::API::V5 do
  describe '::client' do
    let(:settings) { { param1: 'value1', param2: 'value2' } }
    let(:client) { double('client') }

    before { allow(described_class::Client).to receive(:new).with(settings).and_return(client) }

    subject { described_class.client(settings) }

    it 'create new client' do
      is_expected.to eq(client)
    end
  end

  describe '::load_settings' do
    let(:yml_path) { 'file_path' }

    it 'call DefaultSettings::load_from_yml' do
      expect(described_class::DefaultSettings).to receive(:load_from_yml).with(yml_path)
      described_class.load_settings(yml_path)
    end
  end

  describe '::configure' do
    let(:proc) { Proc.new {} }

    it 'call DefaultSettings::build' do
      expect(described_class::DefaultSettings).to receive(:build) do |&block|
        expect(proc).to be(block)
      end
      described_class.configure(&proc)
    end
  end
end
