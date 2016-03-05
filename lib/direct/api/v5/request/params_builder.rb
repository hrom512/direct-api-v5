module Direct::API::V5
  module Request
    # Build params for API request
    module ParamsBuilder
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
            camelize(value)
          else
            value
          end
        end

        def process_array(array)
          array.map { |item| process_value(item) }
        end

        def camelize(value)
          value.to_s.split('_').map(&:capitalize!).join('')
        end
      end
    end
  end
end
