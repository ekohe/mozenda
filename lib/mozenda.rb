require 'singleton'
require 'uri'
require 'pathname'
require 'active_support/core_ext/string/inflections'
require 'faraday'
require 'nokogiri'
require 'nori'
require 'yaml'
require 'aws-sdk'

require "mozenda/version"
require "mozenda/exception"
require "mozenda/configuration"
require "mozenda/xml_generator"
require "mozenda/infrastructure"
require "mozenda/request"
require "mozenda/response"
require "mozenda/model"
require "mozenda/aws"

module Mozenda

  def self.configuration &block
    config = Mozenda::Configuration.instance
    yield(config) if block
    config
  end

  def self.s3_configuration &block
    config = Mozenda::Aws::Configuration.instance
    yield(config) if block
    config
  end

  REPLACEMENT_VALUES = {
    agent_id: "AgentID",
    agent_name: "Agent.Name",
    agent_description: "Agent.Description",
    agent_domain: "Agent.Domain",
    job_id: "JobID",
    job_status: "Job.Status",
    job_created: "Job.Created",
    job_ended: "Job.Ended",
    job_name: "Job.Name",
    job_description: "Job.Description"
  }.freeze

end
