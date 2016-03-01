require 'direct/api/v5/version'
require 'direct/api/v5/default_settings'
require 'direct/api/v5/client'

module Direct
  module API
    # Yandex Direct API V5
    module V5
      class << self
        # Create API client
        # @param settings [Hash] API settings (:host, :auth_token, :client_login)
        # @return [Direct::API::V5::Client] new client object
        #
        # @example Without settings
        #   client = Direct::API::V5.client
        #
        # @example With settings
        #   client = Direct::API::V5.client(host: 'api.direct.yandex.com',
        #                                   auth_token: 'token',
        #                                   client_login: 'login')
        def client(settings = {})
          Client.new(settings)
        end

        # Set default settings from block
        # @example
        #   Direct::API::V5.configure do |config|
        #     config.host = 'api.direct.yandex.com'
        #     config.auth_token = 'token'
        #     config.client_login = 'login'
        #   end
        def configure(&block)
          DefaultSettings.configure(&block)
        end

        # Set default settings from .yml file
        # @param yml_file [String] path to .yml file
        # @example
        #   Direct::API::V5.load_settings('config/yandex_direct_api.yml')
        def load_settings(yml_file)
          DefaultSettings.load_from_yml(yml_file)
        end
      end
    end
  end
end
