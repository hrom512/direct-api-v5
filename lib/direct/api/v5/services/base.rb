require 'direct/api/v5/methods/get'

module Direct
  module API
    module V5
      module Services
        # Base service class
        # @abstract
        class Base
          # Params for API method
          attr_reader :params

          # Initialize service object
          # @param client [Direct::API::V5::Client] API client
          def initialize(client)
            @client = client
            @params = {}
          end

          # Update conditions
          # @param params [Hash] conditions
          # @return [Direct::API::V5::Services::Base] self
          # @example
          #   client = Direct::API::V5.client
          #   client.campaigns.where(id: [1, 2]).get
          def where(params)
            params.each do |key, value|
              @params[:criteria] ||= {}
              @params[:criteria][key.to_sym] = value
            end

            self
          end
        end
      end
    end
  end
end
