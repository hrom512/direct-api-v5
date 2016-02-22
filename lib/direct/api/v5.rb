require 'direct/api/v5/version'
require 'direct/api/v5/default_settings'
require 'direct/api/v5/client'

module Direct
  module API
    module V5
      class << self
        def client(settings = {})
          Client.new(settings)
        end

        def configure(&block)
          DefaultSettings.build(&block)
        end

        def load_settings(yml_file)
          DefaultSettings.load_from_yml(yml_file)
        end
      end
    end
  end
end
