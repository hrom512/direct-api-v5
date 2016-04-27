module Direct::API::V5
  module Refinements
    # Add underscore method to String and Symbol
    module Underscore
      refine String do
        def underscore
          gsub(/(.)([A-Z])/, '\1_\2').downcase
        end
      end

      refine Symbol do
        def underscore
          to_s.underscore.to_sym
        end
      end
    end
  end
end
