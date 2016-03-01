module Direct
  module API
    module V5
      module Services
        # Base service class
        # @abstract
        class Base
          # Params for API method
          attr_reader :params

          # Initialize service object
          # @param client [Direct::API::V5::Client] API client
          def initialize(client)
            @client = client
            @params = {}
          end

          # Update conditions
          # @param params [Hash] conditions
          # @return [Direct::API::V5::Services::Base] self
          # @example
          #   client = Direct::API::V5.client
          #   client.campaigns.where(id: [1, 2]).get
          def where(params)
            params.each do |key, value|
              @params[:selection_criteria] ||= {}
              @params[:selection_criteria][key.to_sym] = value
            end

            self
          end

          # Update fields list
          # @param args [Array] fields list
          # @return [Direct::API::V5::Services::Base] self
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
