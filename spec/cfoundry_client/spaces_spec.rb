require 'spec_helper'

RSpec.describe CfoundryClient::Spaces, :vcr do

  include_context 'make user client'

  describe '#spaces' do
    subject {client.spaces}

    it 'returns a paginator' do
      is_expected.to be_a(CfoundryClient::Paginator)
    end

    it 'returns success' do
      expect(subject.each.to_a).not_to be_empty
    end
  end

  describe '#space_apps' do
    let(:space) { client.spaces.each.first.dig(:metadata, :guid) }
    subject {client.spaces}

    it 'returns a paginator' do
      is_expected.to be_a(CfoundryClient::Paginator)
    end

    it 'returns success' do
      expect(subject.each.to_a).not_to be_empty
    end
  end
end
