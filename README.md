# Direct::API::V5

[![Gem Version](https://badge.fury.io/rb/direct-api-v5.svg)](https://badge.fury.io/rb/direct-api-v5)
[![Travis CI](https://travis-ci.org/hrom512/direct-api-v5.svg?branch=dev)](https://travis-ci.org/hrom512/direct-api-v5)
[![Code Climate](https://codeclimate.com/github/Hrom512/direct-api-v5/badges/gpa.svg)](https://codeclimate.com/github/Hrom512/direct-api-v5)
[![Test Coverage](https://codeclimate.com/github/Hrom512/direct-api-v5/badges/coverage.svg)](https://codeclimate.com/github/Hrom512/direct-api-v5/coverage)
[![Inline docs](http://inch-ci.org/github/hrom512/direct-api-v5.svg?branch=dev)](http://inch-ci.org/github/hrom512/direct-api-v5)
[![Dependency Status](https://gemnasium.com/hrom512/direct-api-v5.svg)](https://gemnasium.com/hrom512/direct-api-v5)


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


#### Get method

For all services method `get` can receive params:

- `fields` (by default all)
- `criteria`
- `limit` and `offset`

For example:

```ruby
api.campaigns.get(fields: [:id, :name],
                  criteria: { states: ['ON'] },
                  limit: 100,
                  offset: 200)
```

Or equivalent:

```ruby
api.campaigns.select(:id, :name).where(:state => :on).limit(100).offset(200).get
```


#### Campaigns

Documentation: https://tech.yandex.ru/direct/doc/ref-v5/campaigns/campaigns-docpage/

Examples:

```ruby
# get
campaigns = api.campaigns.select(:id, :name, :state, :status, :status_payment).get
campaigns = api.campaigns.where(:type => :text_campaign, :state => [:on, :off]).get
campaigns = api.campaigns.limit(100).get

# create
campaigns_data = [
  { name: 'Campaign1', start_date: '2015-01-01', ... },
  { name: 'Campaign2', start_date: '2015-01-02', ... },
  ...
]
campaigns = api.campaigns.add(campaigns_data)

# update
campaigns_data = [
  { id: 1, name: 'Campaign1' },
  { id: 2, name: 'Campaign2' },
  ...
]
campaigns = api.campaigns.update(campaigns_data)

# delete
campaigns = api.campaigns.where(id: [1, 2, 3]).delete

# archive
campaigns = api.campaigns.where(id: [1, 2, 3]).archive

# unarchive
campaigns = api.campaigns.where(id: [1, 2, 3]).unarchive

# suspend
campaigns = api.campaigns.where(id: [1, 2, 3]).suspend

# resume
campaigns = api.campaigns.where(id: [1, 2, 3]).resume
```

#### TODO

## Contributing

1. Fork it ( https://github.com/[my-github-username]/direct-api-v5/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
