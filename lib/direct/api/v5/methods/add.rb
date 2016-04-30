module Direct
  module API
    module V5
      module Methods
        # Direct service add method
        module Add
          # Create objects in Direct
          # @param data [Array] input data
          def add(data = [])
            call_method(:add, data)
          end
        end
      end
    end
  end
end
