require 'spec_helper'
require 'direct/api/v5/refinements/underscore'

describe Direct::API::V5::Refinements::Underscore do
  using described_class

  describe 'String#underscore' do
    it 'underscore string' do
      expect('ConsiderWorkingWeekends'.underscore).to eq('consider_working_weekends')
    end

    it 'return self if already underscore' do
      expect('consider_working_weekends'.underscore).to eq('consider_working_weekends')
    end
  end

  describe 'Symbol#underscore' do
    it 'underscore symbol' do
      expect(:ConsiderWorkingWeekends.underscore).to eq(:consider_working_weekends)
    end
  end
end
