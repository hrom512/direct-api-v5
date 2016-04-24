require 'spec_helper'
require 'direct/api/v5/refinements/camelize'

describe Direct::API::V5::Refinements::Camelize do
  using described_class

  describe 'String#camelize' do
    it 'camelize string' do
      expect('consider_working_weekends'.camelize).to eq('ConsiderWorkingWeekends')
    end

    it 'return self if already camelized' do
      expect('ConsiderWorkingWeekends'.camelize).to eq('ConsiderWorkingWeekends')
    end
  end

  describe 'Symbol#camelize' do
    it 'camelize symbol' do
      expect(:consider_working_weekends.camelize).to eq(:ConsiderWorkingWeekends)
    end
  end
end
