require 'multi_json'
require 'faraday'
require 'direct/api/v5/request/params_builder'
require 'direct/api/v5/request/invalid_response_error'

module Direct
  module API
    module V5
      # Make HTTP requests to Direct API
      module Request
        class << self
          REQUEST_TIMEOUT = 300

          # Make HTTP request to Direct API
          # @param settings [Direct::API::V5::Settings] settings object
          # @param service [Symbol] service name
          # @param method [Symbol] method name
          # @param params [Hash] method params
          # @return [Array] response body and headers
          def send(settings, service, method, params = {})
            host = settings.host
            url = make_url(service)
            body = make_body(method, params)
            headers = make_headers(settings.language, settings.auth_token, settings.client_login)

            response = make_http_request(host, url, body, headers)

            body = parse_response(response.body)
            headers = response.headers

            [body, headers]
          end

          private

          def make_url(service)
            "/json/v5/#{service}/"
          end

          def make_body(method, params)
            body = {
              method: method,
              params: ParamsBuilder.build(params)
            }
            MultiJson.dump(body)
          end

          def make_headers(language, auth_token, client_login)
            {
              'Content-Type' => 'application/json; charset=utf-8',
              'Accept-Language' => language,
              'Authorization' => "Bearer #{auth_token}",
              'Client-Login' => client_login
            }
          end

          def make_http_request(host, url, body, headers)
            conn = Faraday.new(url: "https://#{host}")

            conn.post do |request|
              request.options.timeout = REQUEST_TIMEOUT
              request.url url
              request.body = body
              headers.each do |key, value|
                request.headers[key] = value
              end
            end
          end

          def parse_response(response_body)
            MultiJson.load(response_body, symbolize_keys: true)
          rescue MultiJson::ParseError => e
            raise InvalidResponseError, e.message
          end
        end
      end
    end
  end
end
