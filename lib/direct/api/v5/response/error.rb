module Direct::API::V5
  class Response::Error
    attr_reader :code
    attr_reader :message
    attr_reader :details

    def initialize(error_data = {})
      @code = error_data[:error_code]
      @message = error_data[:error_string]
      @details = error_data[:error_detail]
    end

    def to_h
      {
        code: code,
        message: message,
        details: details
      }
    end
  end
end
