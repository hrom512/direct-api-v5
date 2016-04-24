require 'direct/api/v5/response/units'

module Direct::API::V5
  module Response
    # Base response object
    class Base
      attr_reader :body
      attr_reader :headers

      # Initialize response object
      # @param body [String] response body
      # @param headers [Hash] response headers
      def initialize(body, headers)
        @body = body
        @headers = headers
      end

      # Direct API request ID
      # @return [String]
      def request_id
        @request_id ||= headers[:RequestId]
      end

      # Direct API units
      # @return [Direct::API::V5::Response::Units]
      def units
        @units ||= Units.new(headers[:Units])
      end
    end
  end
end
