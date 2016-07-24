# Direct::API::V5

[![Gem Version](https://badge.fury.io/rb/direct-api-v5.svg)](https://badge.fury.io/rb/direct-api-v5)
[![Travis CI](https://travis-ci.org/hrom512/direct-api-v5.svg?branch=dev)](https://travis-ci.org/hrom512/direct-api-v5)
[![Code Climate](https://codeclimate.com/github/Hrom512/direct-api-v5/badges/gpa.svg)](https://codeclimate.com/github/Hrom512/direct-api-v5)
[![Test Coverage](https://codeclimate.com/github/Hrom512/direct-api-v5/badges/coverage.svg)](https://codeclimate.com/github/Hrom512/direct-api-v5/coverage)
[![Dependency Status](https://gemnasium.com/hrom512/direct-api-v5.svg)](https://gemnasium.com/hrom512/direct-api-v5)

Ruby wrapper for Yandex Direct API V5.


## Installation

Add this line to your application's Gemfile:

    gem 'direct-api-v5'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install direct-api-v5


## Usage

### Settings

1. Load settings from YML file

  ```ruby
  Direct::API::V5.load_settings('config/yandex_direct_api.yml')
  ```

  ```yml
  production:
    host: api.direct.yandex.com
    auth_token: token_string
    client_login: login_string

  development:
    host: api-sandbox.direct.yandex.com
    auth_token: token_string
    client_login: login_string
  ```

2. Configure in block

  ```ruby
  Direct::API::V5.configure do |config|
    config.host = 'api.direct.yandex.com'
    config.auth_token = 'token_string'
    config.client_login = 'login_string'
  end
  ```

### Create client

```ruby
api = Direct::API::V5.client
```

You can set client login (if advertising agency)

```ruby
api = Direct::API::V5.client(client_login: 'login_string')
```

Also you can overwrite any default settings:

```ruby
api = Direct::API::V5.client(host: 'api.direct.yandex.com', auth_token: 'token')
```

### Call methods

Base structure:

```ruby
api.service_name.method(params)
```

For example:

```ruby
response = api.campaigns.get(
  fields: [:id, :name],
  criteria: { states: %(ON) },
  page: { limit: 100, offset: 200 }
)

response.error?
# => false

response.result
# =>
# {
#   Campaigns: [
#     { Id: 1, Name: "Campaign 1" },
#     ...
#   ]
# }

response.request_id
# => 123456

response.units.spent
# => 10

response.units.available
# => 1000

response.units.daily_limit
# => 2000

response.units.raw
# => 10/1000/2000
```

If API return error:

```ruby
response.error?
# => true

response.error.code
# => 54

response.error.message
# => "No rights"

response.error.details
# => "No rights to indicated client"

response.error.to_h
# =>
# {
#   code: 54,
#   message: "No rights",
#   details: "No rights to indicated client"
# }
```


## Contributing

1. Fork it ( https://github.com/hrom512/direct-api-v5/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
