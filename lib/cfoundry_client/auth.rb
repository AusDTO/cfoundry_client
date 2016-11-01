class CfoundryClient
  module Auth
    def login(username, password)
      login_api = cloud_info[:authorization_endpoint]
      params = {
          client_id: @client_id,
          client_secret: @client_secret,
          username: username,
          password: password,
          grant_type: 'password',
          token_token: 'opaque',
          response_type: 'token'
      }

      auth = 'Basic ' + Base64.encode64("#{@client_id}:#{@client_secret}")
      headers = { Authorization: auth, params: params }
      begin
        response = RestClient::Request.execute(method: :post, url: "#{login_api}/oauth/token",
                                    headers: headers, verify_ssl: @verify_ssl)
        response = JSON::parse(response, symbolize_names: true)
        @authorization = "#{response[:token_type]} #{response[:access_token]}"
        @refresh_token = response[:refresh_token]
      rescue RestClient::ExceptionWithResponse => err
        puts err.response
        raise
      end
    end
  end
end