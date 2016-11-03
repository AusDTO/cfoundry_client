class CfoundryClient
  module Spaces
    def spaces(params = {})
      CfoundryClient::Paginator.new(self, "spaces", params)
    end

    def space_apps(space_guid, params = {})
      CfoundryClient::Paginator.new(self, "spaces/#{space_guid}/apps", params)
    end
  end
end