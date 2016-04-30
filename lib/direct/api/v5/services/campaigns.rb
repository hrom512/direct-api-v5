require 'direct/api/v5/services/base'
require 'direct/api/v5/response/campaigns'
require 'direct/api/v5/methods/get'

module Direct::API::V5
  module Services
    # Campaigns service with methods:
    # - get
    class Campaigns < Base
      include Methods::Get

      private

      def response_type
        Response::Campaigns
      end
    end
  end
end
