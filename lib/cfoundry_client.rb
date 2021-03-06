require 'rest-client'
require 'json'
require 'base64'
require 'beefcake'

require 'cfoundry_client/apps'
require 'cfoundry_client/auth'
require 'cfoundry_client/constants'
require 'cfoundry_client/errors'
require 'cfoundry_client/info'
require 'cfoundry_client/jobs'
require 'cfoundry_client/logging'
require 'cfoundry_client/orgs'
require 'cfoundry_client/paginator'
require 'cfoundry_client/request'
require 'cfoundry_client/routes'
require 'cfoundry_client/service_bindings'
require 'cfoundry_client/service_instances'
require 'cfoundry_client/service_plans'
require 'cfoundry_client/services'
require 'cfoundry_client/shared_domains'
require 'cfoundry_client/spaces'
require 'cfoundry_client/version'

class CfoundryClient
  include Apps
  include Auth
  include Constants
  include Errors
  include Info
  include Jobs
  include Logging
  include Orgs
  include Request
  include Routes
  include Spaces
  include ServiceBindings
  include ServiceInstances
  include ServicePlans
  include Services
  include SharedDomains

  def initialize(url, options = {})
    @url = url
    @client_id = options.fetch(:client_id, DEFAULT_CLIENT_ID)
    @client_secret = options.fetch(:client_secret, DEFAULT_CLIENT_SECRET)
    @verify_ssl = options.fetch(:verify_ssl, true)
    @connection = RestClient::Resource.new(@url, verify_ssl: @verify_ssl)
    @authorization = nil
    @refresh_token = nil
  end
end
