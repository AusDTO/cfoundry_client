require 'rest-client'
require 'json'
require 'base64'

require 'cfoundry_client/auth'
require 'cfoundry_client/constants'
require 'cfoundry_client/errors'
require 'cfoundry_client/info'
require 'cfoundry_client/orgs'
require 'cfoundry_client/paginator'
require 'cfoundry_client/request'
require 'cfoundry_client/spaces'
require 'cfoundry_client/version'

class CfoundryClient
  include Auth
  include Constants
  include Errors
  include Info
  include Orgs
  include Request
  include Spaces

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
