require 'direct/api/v5/refinements/camelize'

module Direct::API::V5
  module Request
    # Build params for API request
    module ParamsBuilder
      using Refinements::Camelize

      class << self
        # Build params for API request (recursive replace symbols to camelized strings)
        # @param params [Hash] input params
        # @return [Hash] result params
        def build(params)
          process_hash(params)
        end

        private

        def process_hash(hash)
          result = {}

          hash.each do |key, value|
            key = :selection_criteria if key == :criteria
            key = "#{key.to_s[0..-7]}field_names".to_sym if key.to_s.end_with?('fields')

            new_key = process_value(key)
            new_value = process_value(value)
            result[new_key] = new_value
          end

          result
        end

        def process_value(value)
          if value.is_a?(Hash)
            process_hash(value)
          elsif value.is_a?(Array)
            process_array(value)
          elsif value.is_a?(Symbol)
            value.camelize
          elsif value.is_a?(String) && value =~ /^\d{4}-\d{2}-\d{2}$/
            Date.parse(value)
          else
            value
          end
        end

        def process_array(array)
          array.map { |item| process_value(item) }
        end
      end
    end
  end
end
