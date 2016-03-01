require 'direct/api/v5/settings'
require 'direct/api/v5/services/base'

module Direct
  module API
    module V5
      # Client for Yandex Direct API V5
      class Client
        attr_reader :settings

        # Create new client
        # @param settings [Hash] API settings (:host, :auth_token, :client_login)
        # @return [Direct::API::V5::Client] new client object
        def initialize(settings = {})
          @settings = Settings.new(settings)
        end

        # Direct services methods
        # @return [Direct::API::V5::Services::Base] new service object
        # @example
        #   client = Direct::API::V5.Client.new
        #   service_campaigns = client.campaigns
        def method_missing(method, *_args)
          service_name = camelize(method.to_s)
          if Services.const_defined?(service_name)
            service = Services.const_get(service_name)
            service.new(self)
          else
            super
          end
        end

        private

        def camelize(str)
          str.split('_').map(&:capitalize!).join('')
        end
      end
    end
  end
end
