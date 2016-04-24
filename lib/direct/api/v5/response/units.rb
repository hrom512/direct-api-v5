module Direct::API::V5
  module Response
    # Units response
    class Units
      # Initialize units object
      # @param raw_value [String] RAW units value
      def initialize(raw_value)
        @raw_value = raw_value
      end

      # RAW response
      def raw
        @raw_value
      end

      # Spent units (by request)
      def spent
        @spent ||= parts[0]
      end

      # Available units (in current hour)
      def available
        @available ||= parts[1]
      end

      # Units daily limit
      def daily_limit
        @daily_limit ||= parts[2]
      end

      private

      def parts
        @parts ||= @raw_value.to_s.strip.split('/').map do |part|
          part =~ /^\d+$/ ? part.to_i : nil
        end
      end
    end
  end
end
