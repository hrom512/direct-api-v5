module Direct
  module API
    module V5
      # API client settings
      class Settings
        attr_accessor :host
        attr_accessor :auth_token
        attr_accessor :client_login

        # Create settings object
        # @param settings [Hash] API settings (:host, :auth_token, :client_login)
        def initialize(settings = {})
          @host = settings[:host] || DefaultSettings.host
          @auth_token = settings[:auth_token] || DefaultSettings.auth_token
          @client_login = settings[:client_login] || DefaultSettings.client_login
        end
      end
    end
  end
end
