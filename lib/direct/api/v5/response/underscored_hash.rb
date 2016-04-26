require 'hashie/extensions/method_access'
require 'direct/api/v5/refinements/underscore'

module Direct::API::V5
  module Response
    # Hash with underscored keys and method-based reading
    class UnderscoredHash < Hash
      # Method-based reading
      include Hashie::Extensions::MethodAccess

      using Refinements::Underscore

      # Underscore keys recursively, freeze data
      # @param data [Hash] input hash
      def initialize(data)
        raise 'Invalid param' unless data.is_a?(Hash)

        data.each do |key, value|
          key = key.underscore if key.is_a?(Symbol) || key.is_a?(String)
          value = self.class.new(value) if value.is_a?(Hash)
          self[key] = value
        end

        freeze
      end
    end
  end
end
