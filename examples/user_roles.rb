require 'cfoundry_client'
require 'pp'
require 'optparse'

options = {
    api: CfoundryClient::PCFDEV_URL,
    username: 'admin',
    password: 'admin',
    verify_ssl: false,
}

OptionParser.new do |opts|
  opts.banner = 'Usage: ruby -I lib examples/user_roles.rb [options]'
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
org_roles = []
orgs = {}
c.orgs.each do |org|
  orgs[org[:metadata][:guid]] = org[:entity][:name]
  c.org_user_roles(org[:metadata][:guid]).each do |user|
    org_roles.push({
                 org: org[:entity][:name],
                 user: user[:entity][:username],
                 roles: user[:entity][:organization_roles]
             })
  end
end

puts('Organization roles:')
pp(org_roles)

space_roles = []
c.spaces.each do |space|
  c.space_user_roles(space[:metadata][:guid]).each do |user|
    space_roles.push({
                       org: orgs[space[:entity][:organization_guid]],
                       space: space[:entity][:name],
                       user: user[:entity][:username],
                       roles: user[:entity][:space_roles]
                   })
  end
end

puts
puts('Space roles:')
pp(space_roles)

