module Direct
  module API
    module V5
      # Default API settings store
      class DefaultSettings
        class << self
          attr_accessor :host
          attr_accessor :auth_token
          attr_accessor :client_login

          # Set default settings from .yml file
          # @param yml_file [String] path to .yml file
          def load_from_yml(yml_file)
            settings = YAML.load_file(yml_file)[ENV['RAILS_ENV']] || {}
            @host = settings['host']
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
