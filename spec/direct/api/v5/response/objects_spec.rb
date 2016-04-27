require 'spec_helper'
require 'direct/api/v5/response/objects'

describe Direct::API::V5::Response::Objects do
  class Campaigns < Direct::API::V5::Response::Objects
  end

  let(:body) do
    {
      result: {
        Campaigns: [
          { Id: 1 },
          { Id: 2 }
        ]
      }
    }
  end
  let(:headers) do
    {}
  end

  subject(:response) { Campaigns.new(body, headers) }

  let(:first_object) { response[0] }
  let(:second_object) { response[1] }

  describe '#size' do
    it 'return objects size' do
      expect(response.size).to eq(2)
    end
  end

  describe '#[]' do
    it 'return object' do
      expect(first_object.id).to eq(1)
      expect(second_object.id).to eq(2)
    end
  end

  describe '#to_a' do
    it 'return all objects' do
      expect(response.to_a).to eq([first_object, second_object])
    end
  end

  describe '#map' do
    it 'map objects' do
      expect(response.map(&:id)).to eq([1, 2])
    end
  end

  describe '#each' do
    it 'each objects' do
      acc = []
      response.each { |object| acc << object.id }
      expect(acc).to eq([1, 2])
    end
  end
end
