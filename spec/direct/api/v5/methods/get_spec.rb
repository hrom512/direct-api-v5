require 'spec_helper'
require 'direct/api/v5/services/base'
require 'direct/api/v5/methods/get'

describe Direct::API::V5::Methods::Get do
  class ServiceWithGetMethod < Direct::API::V5::Services::Base
    include Direct::API::V5::Methods::Get
  end

  let(:service) { ServiceWithGetMethod.new(nil) }
  let(:request_params) { service.request_params }

  describe '#get' do
    let(:result) { double }

    it 'use call_method' do
      allow(service).to receive(:call_method).with(:get, criteria: { param2: 'value2' }).and_return(result)
      get_result = service.where(param1: 'value1').get(criteria: { param2: 'value2' })
      expect(get_result).to eq(result)
    end
  end

  describe '#select' do
    it 'return yourself' do
      result = service.select(:field1, :field2)
      expect(result).to eq(service)
    end

    it 'add fields' do
      service.select(:field1, :field2, :child1 => [:field3, :field4], :child2 => :field5)
      expect(request_params[:fields]).to eq([:field1, :field2])
      expect(request_params[:child1_fields]).to eq([:field3, :field4])
      expect(request_params[:child2_fields]).to eq([:field5])
    end

    it 'update fields' do
      service.select(:field1, child: [:field2, :field3]).select(:field4, :child => :field5)
      expect(request_params[:fields]).to eq([:field1, :field4])
      expect(request_params[:child_fields]).to eq([:field2, :field3, :field5])
    end
  end

  describe '#limit' do
    it 'raise error if value not Integer' do
      expect { service.limit('asd') }.to raise_error('Value is not integer')
    end

    it 'raise error if value <= 0' do
      expect { service.limit(0) }.to raise_error('Value must be more then 0')
      expect { service.limit(-1) }.to raise_error('Value must be more then 0')
    end

    it 'return yourself' do
      result = service.limit(10)
      expect(result).to eq(service)
    end

    it 'add limit' do
      service.limit(10)
      expect(request_params[:page][:limit]).to eq(10)
    end

    it 'update limit' do
      service.limit(10).limit(100)
      expect(request_params[:page][:limit]).to eq(100)
    end

    it 'not overwrite offset' do
      service.offset(100).limit(10)
      expect(request_params[:page][:offset]).to eq(100)
    end
  end

  describe '#offset' do
    it 'raise error if value not Integer' do
      expect { service.limit('asd') }.to raise_error('Value is not integer')
    end

    it 'raise error if value <= 0' do
      expect { service.limit(0) }.to raise_error('Value must be more then 0')
      expect { service.limit(-1) }.to raise_error('Value must be more then 0')
    end

    it 'return yourself' do
      result = service.offset(10)
      expect(result).to eq(service)
    end

    it 'add offset' do
      service.offset(10)
      expect(request_params[:page][:offset]).to eq(10)
    end

    it 'update offset' do
      service.offset(10).offset(100)
      expect(request_params[:page][:offset]).to eq(100)
    end

    it 'not overwrite limit' do
      service.limit(10).offset(100)
      expect(request_params[:page][:limit]).to eq(10)
    end
  end
end
