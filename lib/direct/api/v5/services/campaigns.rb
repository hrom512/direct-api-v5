require 'direct/api/v5/services/base'
require 'direct/api/v5/response/campaigns'
require 'direct/api/v5/methods/get'
require 'direct/api/v5/methods/add'

module Direct::API::V5
  module Services
    # Campaigns service with methods:
    # - get
    # - add
    class Campaigns < Base
      include Methods::Get
      include Methods::Add

      private

      def response_type
        Response::Campaigns
      end
    end
  end
end
