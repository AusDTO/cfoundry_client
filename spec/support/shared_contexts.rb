RSpec.shared_context 'make admin client' do
  let(:client) { CfoundryClient.new(CfoundryClient::PCFDEV_URL, verify_ssl: false) }
  before { client.login('admin', 'admin') }
end

RSpec.shared_context 'make user client' do
  let(:client) { CfoundryClient.new(CfoundryClient::PCFDEV_URL, verify_ssl: false) }
  before { client.login('user', 'pass') }
end

RSpec.shared_context 'is paginator' do
  it 'returns a paginator' do
    is_expected.to be_a(CfoundryClient::Paginator)
  end

  it 'returns success' do
    expect(subject.all).not_to be_empty
  end
end
