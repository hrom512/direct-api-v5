require 'direct/api/v5/request'

module Direct::API::V5
  module Services
    # Base service class
    # @abstract
    class Base
      # Direct client
      attr_reader :client
      # Params for API method
      attr_reader :request_params

      # Initialize service object
      # @param client [Direct::API::V5::Client] API client
      def initialize(client)
        @client = client
        @request_params = {}
      end

      # Update conditions
      # @param params [Hash] conditions
      # @return [Direct::API::V5::Services::Base] self
      # @example
      #   client = Direct::API::V5.client
      #   client.campaigns.where(id: [1, 2]).get
      def where(params)
        params.each do |key, value|
          @request_params[:criteria] ||= {}
          @request_params[:criteria][key.to_sym] = value
        end

        self
      end

      protected

      def service_name
        self.class.name.split('::')[-1].downcase
      end

      def response_type
        raise 'Not implemented'
      end

      def call_method(_method, _params = {})
        # TODO
      end
    end
  end
end
