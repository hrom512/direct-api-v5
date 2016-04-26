require 'direct/api/v5/response/underscored_hash'
require 'direct/api/v5/response/object_error'
require 'direct/api/v5/response/object_warning'

module Direct::API::V5
  module Response
    # Object response
    # rubocop:disable Style/AccessorMethodName
    class Object < UnderscoredHash
      attr_reader :errors
      attr_reader :warnings

      def initialize(data)
        set_errors(data.delete(:Errors))
        set_warnings(data.delete(:Warnings))

        super(data)
      end

      private

      def set_errors(data)
        @errors = data || []
        @errors.map! { |attrs| ObjectError.new(attrs) }
      end

      def set_warnings(data)
        @warnings = data || []
        @warnings.map! { |attrs| ObjectWarning.new(attrs) }
      end
    end
  end
end
