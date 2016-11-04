class CfoundryClient
  module Spaces
    ##
    # See https://apidocs.cloudfoundry.org/245/spaces/list_all_spaces.html
    def spaces(params = {})
      CfoundryClient::Paginator.new(self, "spaces", params)
    end

    ##
    # See https://apidocs.cloudfoundry.org/245/spaces/list_all_spaces.html
    def space_apps(space_guid, params = {})
      CfoundryClient::Paginator.new(self, "spaces/#{space_guid}/apps", params)
    end
  end
end