require 'spec_helper'
require 'direct/api/v5/services/base'
require 'direct/api/v5/methods/add'

describe Direct::API::V5::Methods::Add do
  class ServiceWithAddMethod < Direct::API::V5::Services::Base
    include Direct::API::V5::Methods::Add
  end

  let(:service) { ServiceWithAddMethod.new(nil) }

  describe '#add' do
    let(:data) do
      [
        { param1: 'value 1', param2: 'value 2' },
        { param1: 'value 3', param2: 'value 4' }
      ]
    end
    let(:result) { double }

    subject { service.add(data) }

    it 'use call_method' do
      allow(service).to receive(:call_method).with(:add, data).and_return(result)
      is_expected.to eq(result)
    end
  end
end
