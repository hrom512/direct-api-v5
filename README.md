# Direct::API::V5

[![Gem Version](https://badge.fury.io/rb/direct-api-v5.svg)](https://badge.fury.io/rb/direct-api-v5)
[![Travis CI](https://travis-ci.org/hrom512/direct-api-v5.svg?branch=dev)](https://travis-ci.org/hrom512/direct-api-v5)
[![Code Climate](https://codeclimate.com/github/Hrom512/direct-api-v5/badges/gpa.svg)](https://codeclimate.com/github/Hrom512/direct-api-v5)
[![Test Coverage](https://codeclimate.com/github/Hrom512/direct-api-v5/badges/coverage.svg)](https://codeclimate.com/github/Hrom512/direct-api-v5/coverage)
[![Inline docs](http://inch-ci.org/github/hrom512/direct-api-v5.svg?branch=dev)](http://inch-ci.org/github/hrom512/direct-api-v5)

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'direct-api-v5'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install direct-api-v5

## Usage

### Settings

```ruby
Direct::API::V5.load_settings('config/yandex_direct_api.yml')
```

with YML config:

```yml
production:
  host: api.direct.yandex.com
  auth_token: token_string
  client_login: login_string

development:
  host: api-sandbox.direct.yandex.com
  ...
```

Or

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

Set client login (if advertising agency):

```ruby
api = Direct::API::V5.client(client_login: 'login_string')
```

Overwrite any settings:

```ruby
api = Direct::API::V5.client(auth_token: 'new_token', client_login: 'new_login')
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/direct-api-v5/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
