require 'spec_helper'

describe Direct::API::V5, :type => :acceptance do
  let(:settings_path) { File.join(File.dirname(File.dirname(__FILE__)), 'fixtures', 'yandex_direct_api.yml') }

  describe '.configure' do
    subject { described_class.settings }

    before do
      described_class.configure do |config|
        config.host = direct_api_host
        config.auth_token = direct_api_auth_token
        config.client_login = direct_api_client_login
      end
    end

    it 'save settings' do
      expect(subject.host).to eq(direct_api_host)
      expect(subject.auth_token).to eq(direct_api_auth_token)
      expect(subject.client_login).to eq(direct_api_client_login)
    end
  end

  describe '.load_settings' do
    subject { described_class.settings }

    before do
      described_class.load_settings(settings_path)
    end

    it 'load settings from .yml' do
      expect(subject.host).to eq(direct_api_host)
      expect(subject.auth_token).to eq('token_string')
      expect(subject.client_login).to eq('login_string')
    end
  end

  describe '.client' do
    subject { described_class.client }

    before do
      described_class.load_settings(settings_path)
    end

    it 'crate API client' do
      is_expected.to be_a(described_class::Client)
    end

    it 'have settings' do
      expect(subject.settings.host).to eq(direct_api_host)
      expect(subject.settings.auth_token).to eq('token_string')
      expect(subject.settings.client_login).to eq('login_string')
    end

    context 'with settings' do
      let(:client_login) { 'new_client_login' }

      subject { described_class.client(client_login: client_login) }

      it 'overwrite settings' do
        expect(subject.settings.host).to eq(direct_api_host)
        expect(subject.settings.client_login).to eq(client_login)
      end
    end
  end
end
