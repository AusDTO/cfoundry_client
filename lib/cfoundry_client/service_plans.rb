class CfoundryClient
  module ServicePlans
    def service_plans(params = {})
      CfoundryClient::Paginator.new(self, "service_plans", params)
    end
  end
end