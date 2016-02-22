require 'spec_helper'

describe Direct::API::V5::Settings do
  describe '::new' do
    let(:default_host) { 'default_host.com' }
    let(:default_auth_token) { 'default_token' }
    let(:default_client_login) { 'default_login' }

    let(:host) { 'host.com' }
    let(:auth_token) { 'token' }
    let(:client_login) { 'login' }

    before do
      allow(Direct::API::V5::DefaultSettings).to receive(:host).and_return(default_host)
      allow(Direct::API::V5::DefaultSettings).to receive(:auth_token).and_return(default_auth_token)
      allow(Direct::API::V5::DefaultSettings).to receive(:client_login).and_return(default_client_login)
    end

    context 'with params' do
      subject { described_class.new(host: host, auth_token: auth_token, client_login: client_login) }

      it { expect(subject.host).to eq(host) }
      it { expect(subject.auth_token).to eq(auth_token) }
      it { expect(subject.client_login).to eq(client_login) }
    end

    context 'without params' do
      subject { described_class.new }

      it { expect(subject.host).to eq(default_host) }
      it { expect(subject.auth_token).to eq(default_auth_token) }
      it { expect(subject.client_login).to eq(default_client_login) }
    end
  end
end
