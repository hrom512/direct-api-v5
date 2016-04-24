require 'spec_helper'

describe Direct::API::V5::Services::Base do
  let(:service) { described_class.new(nil) }
  let(:request_params) { service.request_params }

  it 'have blank request_params' do
    expect(request_params).to eq({})
  end

  describe '.where' do
    it 'return yourself' do
      result = service.where(attr1: 'value1')
      expect(result).to eq(service)
    end

    it 'add criteria' do
      service.where(attr1: 'value1', attr2: 'value2')
      expect(request_params[:criteria][:attr1]).to eq('value1')
      expect(request_params[:criteria][:attr2]).to eq('value2')
    end

    it 'update criteria' do
      service.where(attr1: 'value1', attr2: 'value2').where(attr1: 'new value', attr3: 'value3')
      expect(request_params[:criteria][:attr1]).to eq('new value')
      expect(request_params[:criteria][:attr2]).to eq('value2')
      expect(request_params[:criteria][:attr3]).to eq('value3')
    end
  end
end
