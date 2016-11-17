require 'spec_helper'

RSpec.describe CfoundryClient::SharedDomains, :vcr do

  include_context 'make user client'

  describe '#shared_domains' do
    subject {client.shared_domains}

    include_context 'is paginator'
  end
end
