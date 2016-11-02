class CfoundryClient
  module Request

    def get(path, params = {})
      before_request
      JSON.parse(subresource(path).get(headers.merge({params: params})), symbolize_names: true)
    end

    def post(path, body = {})
      before_request
      JSON.parse(subresource(path).post(body.to_json, headers))
    end

    def put(path, body = {})
      before_request
      JSON.parse(subresource(path).put(body.to_json, headers))
    end

    def delete(path)
      before_request
      JSON.parse(subresource(path).delete(headers))
    end

    private

    def headers
      {
          content_type: :json,
          accept: :json,
          authorization: @authorization
      }
    end

    def v2_path(path)
      if path =~ /^[\/]?v2/
        path
      else
        "v2/#{path}"
      end
    end

    def subresource(path)
      @connection[v2_path(path)]
    end

    def before_request
      refresh_token_if_required
    end
  end
end
