require 'spec_helper'

describe Direct::API::V5::Services::Base do
  let(:object) { described_class.new(nil) }

  it 'have blank params' do
    expect(object.params).to eq({})
  end

  describe '.where' do
    let(:where_options1) do
      { param1: 'value1', param2: 'value2' }
    end

    let(:where_options2) do
      { param1: %w(new values), param3: 'value3' }
    end

    let(:result_options) do
      { param1: %w(new values), param2: 'value2', param3: 'value3' }
    end

    it 'add params' do
      params = object.where(where_options1).params
      expect(params[:selection_criteria]).to eq(where_options1)
    end

    it 'update params' do
      params = object.where(where_options1).where(where_options2).params
      expect(params[:selection_criteria]).to eq(result_options)
    end
  end

  describe '.select' do
    it 'add fields' do
      params = object.select(:field_name1, :field_name2,
                             :child_list1 => [:field_name3, :field_name4],
                             :child_list2 => :field_name5).params
      expect(params).to eq(field_names: [:field_name1, :field_name2],
                           child_list1_field_names: [:field_name3, :field_name4],
                           child_list2_field_names: [:field_name5])
    end

    it 'update fields' do
      params = object.select(child_list: [:field_name1, :field_name2])
                     .select(:child_list => :field_name3)
                     .params
      expect(params).to eq(child_list_field_names: [:field_name1, :field_name2, :field_name3])
    end
  end
end
