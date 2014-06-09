require 'singleton'
require 'active_support/core_ext/string/inflections'
require 'faraday'
require 'nori'

require "mozenda/version"
require "mozenda/exception"
require "mozenda/configuration"
require "mozenda/infrastructure"
require "mozenda/request"
require "mozenda/response"
require "mozenda/model"

module Mozenda

  def self.configuration &block
    config = Mozenda::Configuration.instance
    yield(config) if block
    config
  end

end
