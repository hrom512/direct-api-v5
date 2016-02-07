require 'direct/api/v5/version'
require 'direct/api/v5/client'
require 'direct/api/v5/settings'

module Direct
  module API
    module V5
      class << self
        def client(settings = {})
          Client.new(settings)
        end

        def configure(&block)
          Settings.configure(&block)
        end

        def load_settings(yml_file)
          Settings.load_from_yml(yml_file)
        end

        def settings
          Settings
        end
      end
    end
  end
end
