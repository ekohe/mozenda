module Mozenda::Aws
  class Configuration

    include ::Singleton

    REQUIRED_OPTIONS = [:access_key, :secret_key, :bucket, :region].freeze

    attr_reader :options


    REQUIRED_OPTIONS.each do |option_name|

      define_method "#{option_name}=" do |option_value|
        @options[option_name] = option_value
      end

      define_method option_name do
        raise Mozenda::ConfigurationException.new("missing required option: #{option_name}") if required_option_undefined?(option_name)
        options[option_name]
      end

    end

    private

    def initialize
      @options = {}
    end

    def required_option_undefined? option_sym
      REQUIRED_OPTIONS.include?(option_sym) && options[option_sym].nil?
    end

    
  end
end
