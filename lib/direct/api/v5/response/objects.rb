require 'direct/api/v5/response/base'
require 'direct/api/v5/response/object'

module Direct::API::V5
  module Response
    # Objects response
    class Objects < Base
      extend Forwardable
      def_delegators :records, :size, :map, :each, :[]

      def to_a
        records
      end

      protected

      def records
        @records ||= body[:result][result_key].map do |record_data|
          Object.new(record_data)
        end
      end

      def result_key
        self.class.name.split('::')[-1].to_sym
      end
    end
  end
end
