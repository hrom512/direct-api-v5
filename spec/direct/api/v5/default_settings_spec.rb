require 'spec_helper'

describe Direct::API::V5::DefaultSettings do
  describe '::load_from_yml' do
    let(:path) { File.join(File.dirname(__FILE__), '../../../fixtures/settings.yml') }

    before { described_class.load_from_yml(path) }

    it { expect(described_class.host).to eq('api-sandbox.direct.yandex.com') }
    it { expect(described_class.auth_token).to eq('token_string') }
    it { expect(described_class.client_login).to eq('login_string') }
  end

  describe '::configure' do
    let(:host) { 'new_host.direct.yandex.com' }
    let(:auth_token) { 'custom_token' }
    let(:client_login) { 'custom_client' }

    before do
      described_class.configure do |conf|
        conf.host = host
        conf.auth_token = auth_token
        conf.client_login = client_login
      end
    end

    it { expect(described_class.host).to eq(host) }
    it { expect(described_class.auth_token).to eq(auth_token) }
    it { expect(described_class.client_login).to eq(client_login) }
  end
end
