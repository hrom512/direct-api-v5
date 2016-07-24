module Direct::API::V5
  class Client
    attr_reader :settings

    def initialize(settings = {})
      @settings = Settings.new(settings)
    end

    # Direct services methods
    def method_missing(method, *args)
      if args.empty?
        Service.new(client: self, service_name: method)
      else
        super
      end
    end
  end
end
