require 'spec_helper'

RSpec.describe CfoundryClient::Services, :vcr do

  include_context 'make user client'

  describe '#services' do
    subject {client.services}

    include_context 'is paginator'
  end
end
