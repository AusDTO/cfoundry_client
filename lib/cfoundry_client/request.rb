class CfoundryClient
  module Request

    def get(path, params = {})
      make_request(path) do |connection|
        connection.get(headers.merge({params: params}))
      end
    end

    def post(path, body = {}, params = {})
      make_request(path) do |connection|
        connection.post(body.to_json, headers.merge(params: params))
      end
    end

    def put(path, body = {}, params = {})
      make_request(path) do |connection|
        connection.put(body.to_json, headers.merge(params: params))
      end
    end

    def delete(path, params = {})
      make_request(path) do |connection|
        connection.delete(headers.merge(params: params))
      end
    end

    def headers
      {
          content_type: :json,
          accept: :json,
          authorization: @authorization
      }
    end

    def make_request(path)
      refresh_token_if_required
      raw_response = yield(@connection[v2_path(path)])
      if raw_response.strip.empty?
        nil
      else
        JSON.parse(raw_response, symbolize_names: true)
      end
    rescue RestClient::ExceptionWithResponse => err
      puts err.response
      raise
    end

    private

    def v2_path(path)
      if path =~ /^[\/]?v2/
        path
      else
        "v2/#{path}"
      end
    end
  end
end
