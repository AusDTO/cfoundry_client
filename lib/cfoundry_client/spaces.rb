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

    ##
    # See https://apidocs.cloudfoundry.org/245/spaces/retrieving_the_roles_of_all_users_in_the_space.html
    def space_user_roles(space_guid, params = {})
      CfoundryClient::Paginator.new(self, "spaces/#{space_guid}/user_roles", params)
    end
  end
end