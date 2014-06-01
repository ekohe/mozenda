module Mozenda::Response
  class Base

    def initialize xml
      @xml = xml
    end

    def to_xml
      @xml
    end

    def to_h
      @hash ||= ::Nori.parse(@xml)
    end

  end
end
