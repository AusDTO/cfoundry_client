VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!

  # scrub sensitive data
  c.before_record do |interaction, cassette|
    interaction.request.headers['Authorization'].each {|s| s.gsub!(/\Abasic \S+\Z/i, 'basic 0123') }
    interaction.request.headers['Authorization'].each {|s| s.gsub!(/\Abearer \S+\Z/i, 'bearer 0123') }
    interaction.request.body.gsub!(/client_secret=\w+/i, 'client_secret=')
    interaction.request.body.gsub!(/password=\w+/i, 'password=')
    if interaction.request.uri.end_with?('/oauth/token')
      json = JSON.parse(interaction.response.body)
      json['access_token'] = '0123'
      json['refresh_token'] = '6789'
      interaction.response.body = JSON.generate(json)
    end
  end

  # Uncomment to force re-recording the cassettes
  #c.default_cassette_options = {record: :all}
end