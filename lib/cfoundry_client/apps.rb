class CfoundryClient
  module Apps
    def apps(params = {})
      CfoundryClient::Paginator.new(self, "apps", params)
    end

    ##
    # https://apidocs.cloudfoundry.org/246/apps/creating_an_app.html
    def create_app(body)
      post('apps', body)
    end

    def update_app(app_guid, body, additional_params = {})
      params = {}
      if additional_params.key(:async)
        params[:async] = additional_params.delete(:async)
      end
      put("apps/#{app_guid}", body, params)
    end

    ##
    # https://apidocs.cloudfoundry.org/246/apps/uploads_the_bits_for_an_app.html
    def update_app_bits(app_guid, resources, application, additional_params = {})
      params = {}
      if additional_params.key?(:async)
        params[:async] = additional_params.delete(:async)
      end
      # don't json encode the application (which should be a file object)
      make_request("apps/#{app_guid}/bits") do |connection|
        connection.put({resources: resources.to_json, application: application}, headers.merge(params: params))
      end
    end

    def app_env(app_guid)
      get("apps/#{app_guid}/env")
    end

    def create_app_route(app_guid, route_guid)
      put("apps/#{app_guid}/routes/#{route_guid}")
    end

    ##
    # https://apidocs.cloudfoundry.org/246/apps/delete_a_particular_app.html
    def delete_app(app_guid, additional_params = {})
      delete("apps/#{app_guid}", additional_params)
    end
  end
end