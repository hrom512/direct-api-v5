require 'direct/api/v5/response/error'

module Direct::API::V5
  # Response module
  module Response
    # Build response object
    # @param response_type [Class] response class
    # @param body [Hash] response body
    # @param headers [Hash] response headers
    # @return [Direct::API::V5::Response::Base] response object
    def self.build(response_type, body, headers)
      response_class = body[:error] ? Error : response_type
      response_class.new(body, headers)
    end
  end
end
