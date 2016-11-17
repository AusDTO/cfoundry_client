require 'spec_helper'

RSpec.describe CfoundryClient::Routes, :vcr do

  include_context 'make user client'

  describe '#routes' do
    subject {client.routes}

    include_context 'is paginator'
  end
end
