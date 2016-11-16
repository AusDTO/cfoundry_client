RSpec.shared_context 'make admin client' do
  let(:client) { CfoundryClient.new(CfoundryClient::PCFDEV_URL, verify_ssl: false) }
  before { client.login('admin', 'admin') }
end

RSpec.shared_context 'make user client' do
  let(:client) { CfoundryClient.new(CfoundryClient::PCFDEV_URL, verify_ssl: false) }
  before { client.login('user', 'pass') }
end

RSpec.shared_context 'app_guid' do
  let(:app_guid) { 'a7601aaf-4bbf-462a-9879-21137c584b8c' }
end

RSpec.shared_context 'is paginator' do
  it 'returns a paginator' do
    is_expected.to be_a(CfoundryClient::Paginator)
  end

  it 'returns success' do
    expect(subject.all).not_to be_empty
  end
end

RSpec.shared_context 'is empty paginator' do
  it 'returns a paginator' do
    is_expected.to be_a(CfoundryClient::Paginator)
  end

  it 'returns success' do
    expect(subject.all).to be_empty
  end
end
