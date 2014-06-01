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
        @options[option_name] = option_value
      end

      define_method option_name do
        raise Mozenda::ConfigurationException.new("missing required option: #{option_name}") if required_option_undefined?(option_name)
        options[option_name]
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

    def required_option_undefined? option_sym
      REQUIRED_OPTIONS.include?(option_sym) && options[option_sym].nil?
    end

  end
end
