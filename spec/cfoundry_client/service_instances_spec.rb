require 'spec_helper'

RSpec.describe CfoundryClient::ServiceInstances, :vcr do

  include_context 'make user client'

  describe '#service_instances' do
    subject {client.service_instances}

    include_context 'is empty paginator'
  end
end
