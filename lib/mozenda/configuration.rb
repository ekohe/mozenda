require 'singleton'

module Mozenda
  class Configuration

    include ::Singleton

    REQUIRED_OPTIONS = [:web_service_key].freeze
    OPTIONAL_OPTIONS = [:base_uri, :service, :rate_limit].freeze
    ALL_OPTIONS = REQUIRED_OPTIONS + OPTIONAL_OPTIONS

    attr_reader :options

    ALL_OPTIONS.each do |option_name|

      define_method "#{option_name}=" do |option_value|
        @options[option_name.to_sym] = option_value
      end

      define_method option_name do
        option_sym = option_name.to_sym
        raise Mozenda::ConfigurationException.new("missing required option: #{option}") unless required_option_defined?(option_sym)
        @options[option_sym]
      end

    end

    private

    DEFAULT_OPTIONS = {
      :base_uri => "https://api.mozenda.com/rest",
      :service => 'Mozenda10',
      :rate_limit => 28.0 / 60.0
    }.freeze

    def initialize
      @options = DEFAULT_OPTIONS.dup
    end

    def required_option_defined? option_sym
      REQUIRED_OPTIONS.include?(option_sym) && @options[option_sym].nil?
    end

  end
end


