# NetboxClientRuby

[![Build Status](https://travis-ci.org/ninech/netbox-client-ruby.svg?branch=master)](https://travis-ci.org/ninech/netbox-client-ruby)
[![Gem Version](https://badge.fury.io/rb/netbox-client-ruby.svg)](https://badge.fury.io/rb/netbox-client-ruby)

This is a gem to pragmatically access your [Netbox instance](https://github.com/digitalocean/netbox)
via it's API from Ruby. This gem is currently only compatible with Netbox v2.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'netbox-client-ruby'
```

And then execute:

    $ bundle

Or install it manually:

    $ gem install netbox-client-ruby

## Usage

### Configuration

Put this somewhere, where it runs, before any call to anything else of Cloudflair.
If you are using Rails, then this would probably be somewhere underneath /config.

```ruby
require 'netbox-client-ruby'
NetboxClientRuby.configure do |config|
  config.netbox.auth.token = 'YOUR_API_TOKEN'
  config.netbox.api_base_url = 'http://netbox.local/api/'

  # these are optional:
  config.netbox.pagination.default_limit = 50
  config.faraday.adapter = Faraday.default_adapter
  config.faraday.request_options = { open_timeout: 1, timeout: 5 }
  config.faraday.logger = :logger # built-in options: :logger, :detailed_logger; default: nil
end
```

### Structure

The methods are aligned with the API as it is defined in Netbox.
You can explore the API endpoints in your browser by opening the API endpoint. Usually that's `http://YOUR_NETBOX/api/`.

So if the URL is `/api/dcim/sites.json`, then the corresponding Ruby code would be `NetboxClientRuby.dcim.sites`.

### Examples

```ruby
# configuration
NetboxClientRuby.configure do |c|
  c.netbox.auth.token = '2e35594ec8710e9922d14365a1ea66f27ea69450'
  c.netbox.api_base_url = 'http://netbox.local/api/'
end

# get all sites
sites = NetboxClientRuby.dcim.sites
puts "There are #{sites.total} sites in your Netbox instance."

# get the first site of the result set
first_site = sites[0]
puts "The first site is called #{first_site.name}."

# filter devices by site
# Note that Netbox filters by *slug*
devices_of_site = NetboxClientRuby.dcim.devices.filter(site: first_site.slug)
puts "#{devices_of_site.total} devices belong to the site. #{devices_of_site}.length devices have been fetched."
```

## Available Objects

Not all objects which the Netbox API exposes are currently implemented. Implementing new objects
[is trivial](https://github.com/ninech/netbox-client-ruby/commit/e3cee19d21a8a6ce480d7c03d23d7c3fbc92417a), though.

* DCIM:
  * Devices
  * Device Roles
  * Device Types
  * Interfaces
  * Manufacturers
  * Platforms
  * Racks
  * Regions
  * Sites
* IPAM:
  * Aggregates
  * IP Addresses
  * Prefixes
  * RIRs
  * Roles
  * VLANs
  * VLAN Groups
  * VRFs
* Tenancy:
  * Tenant
  * Tenant Groups
  
If you can't find the object you need, also check
[the source code](https://github.com/ninech/netbox-client-ruby/tree/master/lib/netbox_client_ruby/api)
if it was added in the meantime without the list above having been updated.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `VERSION`, and then run `bundle exec rake release`,
which will create a git tag for the version, push git commits and tags,
and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are very welcome [on GitHub](https://github.com/ninech/netbox-client-ruby).

Before opening a PR, please

* extend the existing specs
* run rspec
* run rubocop and fix your warnings
* check if this README.md file needs adjustments

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## About

This gem is currently maintained and funded by [nine.ch](https://nine.ch).

[![nine.ch logo](https://blog.nine.ch/assets/logo.png)](https://nine.ch)
