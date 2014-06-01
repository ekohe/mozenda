module Mozenda::Request
  class Base

    def initialize options
      @connection = Mozenda::Infrastructure::Connection.instance
    end

    def send! method = :get
      validate!
      response = @connection.send(method, additional_params)
      Mozenda::Response::Base.new(response.body)
    end

    def validate!
      required_params.each do |param_name|
        raise Mozenda::InvalidRequestException.new("#{operation}: required request param #{param_name} is undefined") if additional_params[param_name].nil?
      end
    end

    private

    def required_params
      self.class.const_get(:REQUIRED_PARAMS)
    end

    def operation
      self.class.const_get(:OPERATION)
    end

    def additional_params
      raise Mozenda::MissingMethodException.new("Abstract method - implement in children class")
    end

  end
end
