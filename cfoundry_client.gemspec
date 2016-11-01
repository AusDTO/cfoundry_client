$:.push File.expand_path('../lib', __FILE__)
require 'cfoundry_client/version'

Gem::Specification.new do |s|
  s.name        = 'cfoundry_client'
  s.version     = CfoundryClient::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = 'Cloud foundry client'
  s.description = 'A simple ruby client for interacting with the cloud foundry API'
  s.authors     = ['Teresa Bradbury']
  s.homepage    = 'http://github.com/ausdto/cfoundry_client'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rest-client'
  s.add_development_dependency 'rspec'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
end