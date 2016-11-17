class CfoundryClient
  module SharedDomains
    ##
    # See https://apidocs.cloudfoundry.org/246/shared_domains/list_all_shared_domains.html
    def shared_domains(params = {})
      CfoundryClient::Paginator.new(self, 'shared_domains', params)
    end
  end
end