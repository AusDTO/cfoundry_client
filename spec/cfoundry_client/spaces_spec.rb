require 'spec_helper'

RSpec.describe CfoundryClient::Spaces, :vcr do

  include_context 'make user client'
  let(:space) { client.spaces.each.first.dig(:metadata, :guid) }

  describe '#spaces' do
    subject {client.spaces}

    include_context 'is paginator'
  end

  describe '#space_apps' do
    subject {client.space_apps(space)}

    include_context 'is paginator'
  end

  describe '#space_users' do
    subject {client.space_users(space)}

    include_context 'is paginator'
  end
end
