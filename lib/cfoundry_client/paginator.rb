class CfoundryClient
  class Paginator
    def initialize(client, path, params={})
      @client = client
      @path = path
      @params = params
    end

    def each
      return enum_for(:each) unless block_given?

      page = @client.get(@path, @params)
      raise ArgError 'Not a paginated resource' unless page.has_key?(:total_pages)
      page[:resources].each do |resource|
        yield resource
      end
      while page[:next_url]
        page = @client.get(page[:next_url])
        page[:resources].each do |resource|
          yield resource
        end
      end
    end

    def all
      return each.to_a
    end

    def first
      return each.first
    end

    def each_guid
      return enum_for(:each_guid) unless block_given?
      each do |entry|
        yield entry.dig(:metadata, :guid)
      end
    end

    def first_guid
      each_guid.first
    end
  end
end