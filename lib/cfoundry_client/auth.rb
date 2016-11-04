class CfoundryClient
  module Auth
    attr_reader :token_expires_at

    def login(username, password)
      params = {
          client_id: @client_id,
          client_secret: @client_secret,
          username: username,
          password: password,
          grant_type: 'password'
      }

      auth = 'Basic ' + Base64.encode64("#{@client_id}:#{@client_secret}")
      headers = { Authorization: auth, params: params }
      request_token(headers)
    end

    def logged_in?
      !@authorization.nil?
    end

    def refresh_token
      raise StateError, 'You must be logged in to refresh the token' unless logged_in?
      params = {
          client_id: @client_id,
          client_secret: @client_secret,
          grant_type: 'refresh_token',
          refresh_token: @refresh_token
      }
      headers = { params: params }
      request_token(headers)
    end

    def token_expires_soon?
      Time.now > @token_expires_at - CfoundryClient::TOKEN_EXPIRY_DRIFT
    end

    def refresh_token_if_required
      refresh_token if logged_in? && token_expires_soon?
    end

    private

    def login_api
      @login_api ||= info[:authorization_endpoint]
    end

    def request_token(headers)
      response = RestClient::Request.execute(method: :post, url: "#{login_api}/oauth/token",
                                             headers: headers, verify_ssl: @verify_ssl)
      response = JSON::parse(response, symbolize_names: true)
      @authorization = "#{response[:token_type]} #{response[:access_token]}"
      @token_expires_at = Time.now + response[:expires_in]
      @refresh_token = response[:refresh_token]
      true
    rescue RestClient::ExceptionWithResponse => err
      puts err.response
      raise
    end
  end
end