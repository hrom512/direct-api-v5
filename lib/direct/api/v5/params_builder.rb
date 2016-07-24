module Direct::API::V5
  class ParamsBuilder
    using Refinements::Camelize

    def initialize(params = {})
      @params = params
    end

    def build
      process_value(@params)
    end

    private

    def process_value(value)
      if value.is_a?(Hash)
        process_hash(value)
      elsif value.is_a?(Array)
        process_array(value)
      elsif value.is_a?(Symbol)
        value.camelize
      else
        value
      end
    end

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

    def process_array(array)
      array.map { |item| process_value(item) }
    end
  end
end
