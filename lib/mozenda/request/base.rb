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

    def default_params
      self.class.const_get(:DEFAULT_PARAMS)
    end

    def additional_params
      @additional_params ||= default_params.dup
    end

    def put_additional_param key, value
      additional_params[key] = value
    end

  end
end
