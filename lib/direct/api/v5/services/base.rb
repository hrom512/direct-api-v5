module Direct
  module API
    module V5
      module Services
        class Base
          attr_reader :params

          def initialize(client)
            @client = client
            @params = {}
          end

          def where(params)
            params.each do |key, value|
              @params[:selection_criteria] ||= {}
              @params[:selection_criteria][key.to_sym] = value
            end

            self
          end

          def select(*args)
            args.each do |arg|
              if arg.is_a?(Hash)
                arg.each do |key, value|
                  set_field_names(value, key)
                end
              else
                set_field_names(arg)
              end
            end

            self
          end

          private

          def set_field_names(field_names, prefix = nil)
            key = prefix.nil? ? :field_names : "#{prefix}_field_names".to_sym
            @params[key] ||= []
            @params[key] |= Array(field_names)
          end
        end
      end
    end
  end
end
