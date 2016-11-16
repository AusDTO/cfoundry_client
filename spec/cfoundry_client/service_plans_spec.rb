require 'spec_helper'

RSpec.describe CfoundryClient::ServicePlans, :vcr do

  include_context 'make user client'

  describe '#service_plans' do
    subject {client.service_plans}

    include_context 'is paginator'
  end
end
