require 'cfoundry_client/logging/envelope.pb'

class CfoundryClient
  module Logging
    def recent_logs(app_guid)
      logging_endpoint = info[:doppler_logging_endpoint].gsub('wss', 'https')
      refresh_token_if_required
      resp = RestClient::Request.execute(
          url: "#{logging_endpoint}/apps/#{app_guid}/recentlogs",
          headers: headers,
          method: :get,
          verify_ssl: @verify_ssl,
          raw_response: true
      )

      boundary = resp.headers[:content_type].match(/(?<=boundary=).*/).to_s
      file = File.open(resp.file, 'rb')
      contents = file.read.split("--#{boundary}")

      contents[0..-2].each.inject([]) do |agg, item|
        unless item.strip.empty?
          agg << CfoundryClient::Logging::Envelope.decode(Beefcake::Buffer.new(item[4..-3]))
        end
        agg
      end
    end
  end
end