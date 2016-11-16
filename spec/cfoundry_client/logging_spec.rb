require 'spec_helper'

RSpec.describe CfoundryClient::Logging, :vcr do

  include_context 'make user client'
  let(:app_guid) { 'a7601aaf-4bbf-462a-9879-21137c584b8c' }

  describe '#app_logs' do
    subject {client.recent_logs(app_guid)}

    it 'is an array' do
      is_expected.to be_a(Array)
    end

    it 'contains envelope structures' do
      subject.each do |entry|
        expect(entry).to be_a(CfoundryClient::Logging::Envelope)
      end
    end
  end
end
