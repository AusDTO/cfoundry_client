class CfoundryClient
  module Apps
    def apps(params = {})
      CfoundryClient::Paginator.new(self, "apps", params)
    end

    def app_env(app_guid)
      get("apps/#{app_guid}/env")
    end
  end
end