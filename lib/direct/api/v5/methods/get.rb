module Direct
  module API
    module V5
      module Methods
        # Direct service get methods
        module Get
          # Get data from Direct
          # @param params [Hash] request params
          # @example
          #   client = Direct::API::V5.client
          #   client.campaigns.get(fields: [:id, :name], page: { limit: 10, offset: 20 })
          def get(params = {})
            call_method(:get, request_params.merge(params))
          end

          # Set fields list
          # @param args [Array] fields list
          # @return self
          # @example
          #   client = Direct::API::V5.client
          #   client.campaigns.select(:id, :name, text_campaign: [:counter_ids, :settings]).get
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

          # Set limit value
          # @param value [Integer] limit value
          # @return self
          # @example
          #   client = Direct::API::V5.client
          #   client.campaigns.limit(100).get
          def limit(value)
            set_limit_option(:limit, value)

            self
          end

          # Set offset value
          # @param value [Integer] offset value
          # @return self
          # @example
          #   client = Direct::API::V5.client
          #   client.campaigns.limit(100).offset(200).get
          def offset(value)
            set_limit_option(:offset, value)

            self
          end

          private

          def set_field_names(field_names, prefix = nil)
            key = prefix.nil? ? :fields : "#{prefix}_fields".to_sym
            @request_params[key] ||= []
            @request_params[key] |= Array(field_names)
          end

          def set_limit_option(key, value)
            raise 'Value is not integer' unless value.is_a?(Integer)
            raise 'Value must be more then 0' unless value > 0

            @request_params[:page] ||= {}
            @request_params[:page][key] = value
          end
        end
      end
    end
  end
end
