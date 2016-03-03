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
    stub_request(:post, "https://#{direct_api_host}/json/v5/#{direct_service}/")
      .with(body: request_body.to_json, headers: direct_api_request_headers)
      .to_return(body: response_body.to_json)
  end

  def direct_api_request_headers
    {
      'Content-Type' => 'application/json; charset=utf-8',
      'Accept-Language' => direct_api_language,
      'Authorization' => "Bearer #{direct_api_auth_token}",
      'Client-Login' => direct_api_client_login
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
end

RSpec.configure do |config|
  config.include DirectApiHelper
end
