module Direct::API::V5
  class Error < StandardError
  end

  class RequestError < Error
  end

  class InvalidResponseError < Error
  end
end
