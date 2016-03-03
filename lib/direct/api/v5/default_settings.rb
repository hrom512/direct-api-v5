module Direct
  module API
    module V5
      # Default API settings store
      class DefaultSettings
        class << self
          DEFAULT_HOST = 'api.direct.yandex.com'
          DEFAULT_LANGUAGE = 'en'

          attr_accessor :host
          attr_accessor :language
          attr_accessor :auth_token
          attr_accessor :client_login

          # Return configured host or default value
          def host
            @host || DEFAULT_HOST
          end

          # Return configured language or default value
          def language
            @language || DEFAULT_LANGUAGE
          end

          # Set default settings from .yml file
          # @param yml_file [String] path to .yml file
          def load_from_yml(yml_file)
            settings = YAML.load_file(yml_file)[ENV['RAILS_ENV']] || {}
            @host = settings['host']
            @language = settings['language']
            @auth_token = settings['auth_token']
            @client_login = settings['client_login']
          end

          # Set default settings from block
          def configure
            yield(self)
          end
        end
      end
    end
  end
end
