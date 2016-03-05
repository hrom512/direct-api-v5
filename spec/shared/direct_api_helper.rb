require 'direct/api/v5'

module DirectApiHelper
  def make_direct_api_client
    Direct::API::V5.client(
      host: direct_api_host,
      language: direct_api_language,
      auth_token: direct_api_auth_token,
      client_login: direct_api_client_login
    )
  end

  def stub_direct_api_request(direct_service, request_body, response_body)
    url = "https://#{direct_api_host}/json/v5/#{direct_service}/"
    request_body = request_body.to_json if request_body.is_a?(Hash)
    response_body = response_body.to_json if response_body.is_a?(Hash)
    stub_request(:post, url)
      .with(body: request_body, headers: direct_api_request_headers)
      .to_return(body: response_body, headers: direct_api_response_headers)
  end

  def direct_api_request_headers
    {
      'Content-Type' => 'application/json; charset=utf-8',
      'Accept-Language' => direct_api_language,
      'Authorization' => "Bearer #{direct_api_auth_token}",
      'Client-Login' => direct_api_client_login
    }
  end

  def direct_api_response_headers
    {
      'Content-Type' => 'application/json',
      'RequestId' => direct_api_request_id,
      'Units' => direct_api_units
    }
  end

  def direct_api_host
    'api.direct.yandex.com'
  end

  def direct_api_language
    'en'
  end

  def direct_api_auth_token
    'token'
  end

  def direct_api_client_login
    'client_id'
  end

  def direct_api_request_id
    '8695244274068608439'
  end

  def direct_api_units
    '10/20828/64000'
  end
end

RSpec.configure do |config|
  config.include DirectApiHelper
end
