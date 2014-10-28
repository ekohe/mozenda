module Mozenda::Request
  class Base

    def initialize options
      @connection = Mozenda::Infrastructure::Connection.instance
    end

    def send! method = :post
      validate!
      response = @connection.send(method, additional_params)
      response_class.new(response)
    end

    def validate!
      required_params.each do |param_name|
        raise Mozenda::InvalidRequestException.new("Request #{operation}: required param '#{param_name}' is undefined") if additional_params[param_name].nil?
      end
    end

    protected

    def include_status_url? params
      status_url = params[:status_url] || ""
      replacement_values = params[:replacement_values] || []
      !(status_url.empty? || replacement_values.empty?)
    end

    def format_status_url params
      status_url = params[:status_url] || ""
      replacement_values = params[:replacement_values] || []
      unless status_url.empty? || replacement_values.empty?
        uri = URI(status_url)
        params = URI.decode_www_form(uri.query || [])
        replacement_values.each do |name|
          value = Mozenda::REPLACEMENT_VALUES[name]
          params << [name, value]
        end
        uri.query = URI.encode_www_form(params)
        status_url = uri.to_s
        Mozenda::REPLACEMENT_VALUES.values.each do |replacement_value|
          status_url = status_url.gsub(replacement_value, "%#{replacement_value}%")
        end
      end
      status_url
    end

    private

    def response_class
      class_name = operation.gsub(/\./, "")
      full_class_name = "Mozenda::Response::#{class_name}"
      full_class_name.constantize
    end

    def required_params
      self.class.const_get(:REQUIRED_PARAMS)
    end

    def operation
      self.class.const_get(:OPERATION)
    end

    def additional_params
      @additional_params ||= {"Operation" => operation}
    end

    def put_additional_param key, value
      additional_params[key] = value
    end

  end
end
