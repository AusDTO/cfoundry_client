RSpec.shared_context 'make admin client' do
  let(:client) { CfoundryClient.new(CfoundryClient::PCFDEV_URL, verify_ssl: false) }
  before { client.login('admin', 'admin') }
end

RSpec.shared_context 'make user client' do
  let(:client) { CfoundryClient.new(CfoundryClient::PCFDEV_URL, verify_ssl: false) }
  before { client.login('user', 'pass') }
end
