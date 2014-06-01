module Mozenda::Infrastructure
  class Connection

    include ::Singleton

    def initialize
      config = Mozenda::Configuration.instance
      default_params = {
        "WebServiceKey" => config.web_service_key,
        "Service" => config.service
      }
      @client = ::Faraday.new(url: config.base_uri, params: default_params)
    end

    def get params
      send_request(:get, params)
    end

    def post params
      send_request(:post, params)
    end

    private

    def send_request type, params
      response = @client.send(type) do |request|
        request.params.merge!(params)
      end
      response.body
    end

  end
end
