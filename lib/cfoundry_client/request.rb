class CfoundryClient
  module Request

    def get(path, params = {})
      wrap_request(path) do |connection|
        connection.get(headers.merge({params: params}))
      end
    end

    def post(path, body = {})
      wrap_request(path) do |connection|
        connection.post(body.to_json, headers)
      end
    end

    def put(path, body = {})
      wrap_request(path) do |connection|
        connection.put(body.to_json, headers)
      end
    end

    def delete(path)
      wrap_request(path) do |connection|
        connection.delete(headers)
      end
    end

    def headers
      {
          content_type: :json,
          accept: :json,
          authorization: @authorization
      }
    end

    private

    def v2_path(path)
      if path =~ /^[\/]?v2/
        path
      else
        "v2/#{path}"
      end
    end

    def wrap_request(path)
      refresh_token_if_required
      raw_response = yield(@connection[v2_path(path)])
      JSON.parse(raw_response, symbolize_names: true)
    rescue RestClient::ExceptionWithResponse => err
      puts err.response
      raise
    end
  end
end
