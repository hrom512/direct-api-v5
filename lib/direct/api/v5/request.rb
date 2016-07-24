module Direct::API::V5
  class Request
    REQUEST_TIMEOUT = 300

    def initialize(settings:, service_name:, api_method:, params: {})
      @settings = settings
      @service_name = service_name
      @api_method = api_method
      @params = params
    end

    def send
      response = make_http_request
      response_body = parse_response(response.body)

      [response_body, response.headers]
    end

    private

    def make_http_request
      connection = Faraday.new(url: "https://#{api_host}")

      connection.post do |request|
        request.options.timeout = REQUEST_TIMEOUT
        request.url api_url
        request.body = body
        headers.each do |key, value|
          request.headers[key] = value
        end
      end
    rescue Faraday::Error => e
      raise RequestError, e.message
    end

    def parse_response(response_body)
      MultiJson.load(response_body, symbolize_keys: true)
    rescue MultiJson::ParseError => e
      raise InvalidResponseError, e.message
    end

    def api_host
      @settings.host
    end

    def api_url
      "/json/v5/#{@service_name}/"
    end

    def headers
      {
        'Content-Type' => 'application/json; charset=utf-8',
        'Accept-Language' => @settings.language,
        'Authorization' => "Bearer #{@settings.auth_token}",
        'Client-Login' => @settings.client_login
      }
    end

    def body
      MultiJson.dump(
        method: @api_method,
        params: ParamsBuilder.new(@params).build
      )
    end
  end
end
