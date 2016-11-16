class CfoundryClient
  module ServiceInstances
    def service_instances(params = {})
      CfoundryClient::Paginator.new(self, "service_instances", params)
    end

    def create_service_instance(name, service_plan_guid, space_guid, additional_params = {})
      params = {}
      if additional_params.key?(:accepts_incomplete)
        params[:accepts_incomplete] = additional_params.delete(:accepts_incomplete)
      end
      body = additional_params
      body[:name] = name
      body[:service_plan_guid] = service_plan_guid
      body[:space_guid] = space_guid
      post('service_instances', body, params)
    end
  end
end