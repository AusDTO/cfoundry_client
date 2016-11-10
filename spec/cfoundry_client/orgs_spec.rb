require 'spec_helper'

RSpec.describe CfoundryClient::Orgs, :vcr do

  include_context 'make user client'
  let(:org) { client.orgs.each.first.dig(:metadata, :guid) }

  describe '#orgs' do
    subject {client.orgs}

    include_context 'is paginator'
  end

  describe '#org_user_roles' do
    subject {client.org_user_roles(org)}

    include_context 'is paginator'
  end
end
