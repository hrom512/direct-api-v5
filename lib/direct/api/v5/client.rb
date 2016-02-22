require 'direct/api/v5/settings'
require 'direct/api/v5/services/base'
require 'direct/api/v5/services/campaigns'

module Direct
  module API
    module V5
      class Client
        attr_reader :settings

        def initialize(settings = {})
          @settings = Settings.new(settings)
        end

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
