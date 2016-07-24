module Direct::API::V5
  class Response
    attr_reader :body
    attr_reader :headers

    def initialize(body, headers)
      @body = body
      @headers = headers
    end

    def result
      body[:result]
    end

    def request_id
      @request_id ||= headers[:RequestId]
    end

    def units
      @units ||= Units.new(headers[:Units])
    end

    def error?
      body.key?(:error)
    end

    def error
      return unless error?
      @error ||= Error.new(body[:error])
    end
  end
end
