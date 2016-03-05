require 'spec_helper'

describe Direct::API::V5::Methods::Get do
  module Direct::API::V5::Services
    class ServiceWithGetMethod < Base
      include Direct::API::V5::Methods::Get
    end
  end

  let(:service_class) { Direct::API::V5::Services::ServiceWithGetMethod }
  let(:service) { service_class.new(nil) }

  describe '#select' do
    it 'add fields' do
      params = service.select(:field1, :field2, :child1 => [:field3, :field4], :child2 => :field5).params
      expect(params[:fields]).to eq([:field1, :field2])
      expect(params[:child1_fields]).to eq([:field3, :field4])
      expect(params[:child2_fields]).to eq([:field5])
    end

    it 'update fields' do
      params = service.select(:field1, child: [:field2, :field3]).select(:field4, :child => :field5).params
      expect(params[:fields]).to eq([:field1, :field4])
      expect(params[:child_fields]).to eq([:field2, :field3, :field5])
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

    it 'add limit' do
      params = service.limit(10).params
      expect(params[:page][:limit]).to eq(10)
    end

    it 'update limit' do
      params = service.limit(10).limit(100).params
      expect(params[:page][:limit]).to eq(100)
    end

    it 'not overwrite offset' do
      params = service.offset(100).limit(10).params
      expect(params[:page][:offset]).to eq(100)
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

    it 'add offset' do
      params = service.offset(10).params
      expect(params[:page][:offset]).to eq(10)
    end

    it 'update offset' do
      params = service.offset(10).offset(100).params
      expect(params[:page][:offset]).to eq(100)
    end

    it 'not overwrite limit' do
      params = service.limit(10).offset(100).params
      expect(params[:page][:limit]).to eq(10)
    end
  end
end
