module Mozenda::Response
  class Base

    attr_reader :response

    def initialize http_response
      @response = http_response
      @xml = @response.body
    end

    def valid?
      !body_hash.nil?
    end

    def success?
      return false unless valid?
      result = body_hash["Result"] || ""
      result.downcase == "success"
    end

    def to_xml
      @xml
    end

    def to_h
      @hash ||= ::Nori.parse(@xml)
    end

    def name
      self.class.const_get(:NAME)
    end

    protected

    def body_hash
      to_h[name]
    end

  end
end
