require 'cfoundry_client'
require 'pp'
require 'optparse'
require 'csv'

options = {
    api: CfoundryClient::PCFDEV_URL,
    username: 'admin',
    password: 'admin',
    verify_ssl: false,
}

OptionParser.new do |opts|
  opts.banner = 'Usage: ruby -I lib examples/all_apps.rb [options]'
  opts.on('-h', '--help', 'Prints this help') do
    puts opts
    exit
  end
  opts.on('-a', '--api API', 'cloud foundry api url (including scheme)') do |url|
    options[:api] = url
  end
  opts.on('-u', '--username USERNAME', 'username to log in with') do |username|
    options[:username] = username
  end
  opts.on('-p', '--password PASSWORD', 'password to log in with') do |password|
    options[:password] = password
  end
  opts.on('-s', '--ssl', 'enable SSL verification') do
    options[:verify_ssl] = true
  end
end.parse(ARGV)

c = CfoundryClient.new(options[:api], verify_ssl: options[:verify_ssl])
c.login(options[:username], options[:password])
orgs = {}
c.orgs.each do |org|
  orgs[org[:metadata][:guid]] = org[:entity][:name]
end

spaces = {}
c.spaces.each do |space|
  spaces[space[:metadata][:guid]] =
    {
      space_name: space[:entity][:name],
      org_name: orgs[space[:entity][:organization_guid]]
    }
end

apps = []
c.apps.each do |app|
  s_guid = app[:entity][:space_guid]
  apps.push(
    {
      app_name: app[:entity][:name],
      space_name: spaces[s_guid][:space_name],
      org_name: spaces[s_guid][:org_name]
    }
  )
end

apps.sort_by! { |app| [app[:org_name], app[:space_name], app[:app_name]] }

CSV.open('apps.csv', 'wb') do |csv|
  csv << ['org', 'space', 'app']
  apps.each { |app| csv << [app[:org_name], app[:space_name], app[:app_name]] }
end
