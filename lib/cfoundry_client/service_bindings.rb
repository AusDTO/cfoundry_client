class CfoundryClient
  module ServiceBindings
    def service_bindings(params = {})
      CfoundryClient::Paginator.new(self, "service_bindings", params)
    end

    def create_service_binding(service_instance_guid, app_guid, additional_params = {})
      body = additional_params
      body[:service_instance_guid] = service_instance_guid
      body[:app_guid] = app_guid
      post('service_bindings', body)
    end
  end
end