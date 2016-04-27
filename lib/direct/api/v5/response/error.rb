require 'direct/api/v5/response/base'

module Direct::API::V5
  module Response
    # Error response
    class Error < Base
      # Response is error
      def error?
        true
      end

      # Error code
      # @return [Integer]
      def code
        error_data[:error_code]
      end

      # Error message
      # @return [String]
      def message
        error_data[:error_string]
      end

      # Error details
      # @return [String]
      def details
        error_data[:error_detail]
      end

      # Error code, message and details
      # @return [Hash]
      def to_h
        {
          code: code,
          message: message,
          details: details
        }
      end

      private

      def error_data
        body[:error] || {}
      end
    end
  end
end
