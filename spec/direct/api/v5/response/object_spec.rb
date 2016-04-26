require 'spec_helper'
require 'direct/api/v5/response/object'

describe Direct::API::V5::Response::Object do
  let(:object_attrs) do
    {
      Id: 1,
      Name: 'Campaign 1'
    }
  end

  subject(:response) { described_class.new(object_attrs) }

  it { is_expected.to be_a(Direct::API::V5::Response::UnderscoredHash) }

  describe '#errors' do
    subject { response.errors }

    it { is_expected.to eq([]) }

    context 'with errors' do
      let(:object_attrs) do
        {
          Id: 1,
          Errors: [
            { Code: 1, Message: 'Message 1', Details: 'Description 1' },
            { Code: 2, Message: 'Message 2', Details: 'Description 2' }
          ]
        }
      end

      let(:error1) { double('error1') }
      let(:error2) { double('error2') }

      before do
        error_class = Direct::API::V5::Response::ObjectError
        allow(error_class).to receive(:new).with(object_attrs[:Errors][0]).and_return(error1)
        allow(error_class).to receive(:new).with(object_attrs[:Errors][1]).and_return(error2)
      end

      it 'return errors' do
        is_expected.to eq([error1, error2])
      end
    end
  end

  describe '#warnings' do
    subject { response.warnings }

    it { is_expected.to eq([]) }

    context 'with warnings' do
      let(:object_attrs) do
        {
          Id: 1,
          Warnings: [
            { Code: 1, Message: 'Message 1', Details: 'Description 1' },
            { Code: 2, Message: 'Message 2', Details: 'Description 2' }
          ]
        }
      end

      let(:warning1) { double('warning1') }
      let(:warning2) { double('warning2') }

      before do
        warning_class = Direct::API::V5::Response::ObjectWarning
        allow(warning_class).to receive(:new).with(object_attrs[:Warnings][0]).and_return(warning1)
        allow(warning_class).to receive(:new).with(object_attrs[:Warnings][1]).and_return(warning2)
      end

      it 'return warnings' do
        is_expected.to eq([warning1, warning2])
      end
    end
  end
end
