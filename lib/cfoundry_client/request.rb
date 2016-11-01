class CfoundryClient
  module Request

    def get(path, params = {})
      JSON.parse(@connection[path].get(headers.merge({params: params})), symbolize_names: true)
    end

    def post(path, body = {})
      JSON.parse(@connection[path].post(body.to_json, headers))
    end

    def put(path, body = {})
      JSON.parse(@connection[path].put(body.to_json, headers))
    end

    def delete(path)
      JSON.parse(@connection[path].delete(headers))
    end

    private

    def headers
      {
          content_type: :json,
          accept: :json,
          authorization: @authorization
      }
    end
  end
end