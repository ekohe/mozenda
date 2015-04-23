module Mozenda::Infrastructure
  class Connection

    include ::Singleton

    attr_reader :debug

    def initialize
      config = Mozenda::Configuration.instance
      default_params = {
        "WebServiceKey" => config.web_service_key,
        "Service" => config.service
      }
      @client = ::Faraday.new(url: config.base_uri, params: default_params)
      @multipart_client = ::Faraday.new(url: config.base_uri, params: default_params) do |builder|
        builder.request :multipart
        builder.request :url_encoded
        builder.adapter :net_http
      end
      
      @debug = config.debug
    end

    def get params
      send_request(:get, params)
    end

    def post params
      send_request(:post, params)
    end

    def multipart params, file_path
      file = ::Faraday::UploadIO.new(file_path, 'application/xml')
      @multipart_client.post do |request|
        request.params.merge!(params)
        request.body = {
          "file" => file
        }
      end
    end

    private

    def send_request type, params
      if debug
        puts "-"*110
        puts "--- #{@client.build_url} ---"
        puts "--- #{params} ---"
        puts "-"*110
      end
      
      @client.send(type) do |request|
        request.params.merge!(params)
      end
    end

  end
end
