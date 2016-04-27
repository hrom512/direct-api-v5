module Direct::API::V5
  module Refinements
    # Add camelize method to String and Symbol
    module Camelize
      refine String do
        def camelize
          if self =~ /[A-Z]/
            self
          else
            split('_').map(&:capitalize).join('')
          end
        end
      end

      refine Symbol do
        def camelize
          to_s.camelize.to_sym
        end
      end
    end
  end
end
