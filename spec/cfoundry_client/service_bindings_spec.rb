require 'spec_helper'

RSpec.describe CfoundryClient::ServiceBindings, :vcr do

  include_context 'make user client'

  describe '#service_bindings' do
    subject {client.service_bindings}

    include_context 'is empty paginator'
  end
end
