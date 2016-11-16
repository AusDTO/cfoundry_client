class CfoundryClient
  module Services
    def services(params = {})
      CfoundryClient::Paginator.new(self, "services", params)
    end
  end
end