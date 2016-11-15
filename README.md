# Cloud foundry client for ruby

This gem provides a thin wrapper around the [cloud foundry API v2](https://apidocs.cloudfoundry.org/).
It is still in it's very early stages. If you have any suggestions or comments,
feel free to raise issues or pull requests.

## Basic usage

Add to your Gemfile

```
gem "cfoundry_client", git: "https://github.com/ausdto/cfoundry_client"
```

To make a request

```
client = CfoundryClient.new('API_URL')
client.login('USERNAME', 'PASSWORD')
client.info
```

All JSON data is returned as a hash with symbolised keys.

There are some additional examples in the [examples folder](examples).

## Pagination

Paginated API endpoints return a `CfoundryClient::Paginator` object.
The `Paginator#each` method behaves like the `#each` method for an array.
If no block is given, `Paginator#each` returns an Enumerator.

To print the names of all spaces

```
client.spaces.each { |space| puts(space[:entity][:name]) }
```

To find the guid of the first space with a given name

```
c.spaces(q: 'name:pcfdev-space').first[:metadata][:guid]
```

## File structure

File | Description
---- | -----------
[cfoundry_client.rb](lib/cfoundry_client.rb) | The base class for the client. This class includes all the other modules.
[request.rb](lib/cfoundry_client/request.rb) | Defines basic `#get`, `#post`, `#put` and `#delete` methods
[auth.rb](lib/cfoundry_client/auth.rb) | Defines authentication methods like `#login`
[paginator.rb](lib/cfoundry_client/paginator.rb) | Provides an enumerator over paginated results
[\<api-endpoint\>.rb](lib/cfoundry_client) | Defines the methods for endpoints below `/v2/<api-endpoint>`

## Development

### Console

To get a console with the gem pre-loaded, run

```
rake console
```

### Tests

You can run the tests using the command

```
bundle exec rspec
```

The tests use [VCR](https://github.com/vcr/vcr) to record calls to the cloud
foundry API. If you are writing any new tests, you will need to set up
[PCF Dev](https://pivotal.io/pcf-dev) to record the interactions. If
you wish to re-record any operation, add the `record: :all` tag to the test.
To re-record all tests, uncomment the `default_cassette_options` line in
[spec/support/vcr.rb](spec/support/vcr.rb).

### Documentation

To build the API documentation, run `rake rdoc`.

## Contributing

This project welcomes all github issues and pull requests. Please read the section
on file structure before adding any additional functionality.

