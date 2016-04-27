require 'spec_helper'
require 'direct/api/v5/response/object'

describe Direct::API::V5::Response::Object do
  let(:object_attrs) do
    { Id: 1 }
  end

  subject(:response) { described_class.new(object_attrs) }

  it { is_expected.to be_a(Direct::API::V5::Response::UnderscoredHash) }

  describe '#errors?' do
    subject { response.errors? }

    context 'without errors' do
      it { is_expected.to be_falsey }
    end

    context 'with blank errors' do
      let(:object_attrs) do
        { Id: 1, Errors: [] }
      end

      it { is_expected.to be_falsey }
    end

    context 'with errors' do
      let(:object_attrs) do
        {
          Id: 1,
          Errors: [
            { Code: 1, Message: 'Message 1', Details: 'Description 1' }
          ]
        }
      end

      it { is_expected.to be_truthy }
    end
  end

  describe '#warnings?' do
    subject { response.warnings? }

    context 'without warnings' do
      it { is_expected.to be_falsey }
    end

    context 'with blank warnings' do
      let(:object_attrs) do
        { Id: 1, Warnings: [] }
      end

      it { is_expected.to be_falsey }
    end

    context 'with warnings' do
      let(:object_attrs) do
        {
          Id: 1,
          Warnings: [
            { Code: 1, Message: 'Message 1', Details: 'Description 1' }
          ]
        }
      end

      it { is_expected.to be_truthy }
    end
  end
end
