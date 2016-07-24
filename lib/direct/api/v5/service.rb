module Direct::API::V5
  class Service
    def initialize(client:, service_name:)
      @client = client
      @service_name = service_name
    end

    # Direct API methods
    def method_missing(method, *args)
      params = args[0] || {}
      if params.is_a?(Hash)
        call_api_method(method, params)
      else
        super
      end
    end

    protected

    def call_api_method(method_name, params = {})
      request = Request.new(
        settings: @client.settings,
        service_name: @service_name,
        api_method: method_name,
        params: params
      )
      body, headers = request.send

      Response.new(body, headers)
    end
  end
end
