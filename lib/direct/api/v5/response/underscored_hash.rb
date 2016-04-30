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
          new_key = process_key(key)
          new_value = process_value(value)
          self[new_key] = new_value
        end

        freeze
      end

      private

      def process_key(key)
        if key.is_a?(Symbol) || key.is_a?(String)
          key.underscore
        else
          key
        end
      end

      def process_value(value)
        if value.is_a?(Hash)
          self.class.new(value)
        elsif value.is_a?(String) && value =~ /^\d{4}-\d{2}-\d{2}$/
          Date.parse(value)
        else
          value
        end
      end
    end
  end
end
