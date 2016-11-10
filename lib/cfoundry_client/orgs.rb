class CfoundryClient
  module Orgs
    ##
    # See https://apidocs.cloudfoundry.org/245/organizations/list_all_organizations.html
    def orgs(params = {})
      CfoundryClient::Paginator.new(self, "organizations", params)
    end
    alias_method :organizations, :orgs

    ##
    # See https://apidocs.cloudfoundry.org/245/organizations/retrieving_the_roles_of_all_users_in_the_organization.html
    def org_user_roles(org_guid, params = {})
      CfoundryClient::Paginator.new(self, "organizations/#{org_guid}/user_roles", params)
    end
    alias_method :organization_user_roles, :org_user_roles
  end
end