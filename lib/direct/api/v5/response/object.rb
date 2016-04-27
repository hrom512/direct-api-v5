require 'direct/api/v5/response/underscored_hash'

module Direct::API::V5
  module Response
    # Object response
    class Object < UnderscoredHash
      def errors?
        self[:errors] && !self[:errors].empty?
      end

      def warnings?
        self[:warnings] && !self[:warnings].empty?
      end
    end
  end
end
