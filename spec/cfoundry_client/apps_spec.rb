require 'spec_helper'

RSpec.describe CfoundryClient::Apps, :vcr do

  include_context 'make user client'
  include_context 'app_guid'

  describe '#apps' do
    subject {client.apps}

    include_context 'is paginator'
  end

  describe '#app_env' do
    subject {client.app_env(app_guid)}

    it 'has application_env_json key' do
      is_expected.to have_key(:application_env_json)
    end
  end
end
