class CfoundryClient
  module Routes
    ##
    # See https://apidocs.cloudfoundry.org/246/routes/list_all_routes.html
    def routes(params = {})
      CfoundryClient::Paginator.new(self, 'routes', params)
    end

    ##
    # https://apidocs.cloudfoundry.org/246/routes/creating_a_route.html
    def create_route(domain_guid, space_guid, additional_params = {})
      params = {}
      if additional_params.key?(:generate_port)
        params[:generate_port] = additional_params.delete(:generate_port)
      end
      body = additional_params
      body[:domain_guid] = domain_guid
      body[:space_guid] = space_guid
      post('routes', body, params)
    end
  end
end