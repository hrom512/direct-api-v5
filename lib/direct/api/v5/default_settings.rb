module Direct
  module API
    module V5
      class DefaultSettings
        class << self
          attr_accessor :host
          attr_accessor :auth_token
          attr_accessor :client_login

          def load_from_yml(yml_file)
            settings = YAML.load_file(yml_file)[ENV['RAILS_ENV']] || {}
            @host = settings['host']
            @auth_token = settings['auth_token']
            @client_login = settings['client_login']
          end

          def build
            yield(self)
          end
        end
      end
    end
  end
end
