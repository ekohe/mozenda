module Mozenda::Request
  class AgentRun < Mozenda::Request::Base

    def initialize options
      super
      put_additional_param("AgentID", options[:agent_id])
      params = options[:params] || {}
      params.each_pair do |name, value|
        put_additional_param("AgentParameter.#{name}", value)
      end
      job_params = options[:job_params] || {}
      put_additional_param("Job.StatusUrl", format_status_url(job_params)) unless job_params.empty?
    end

    private

    OPERATION = "Agent.Run"
    REQUIRED_PARAMS = ["AgentID", "Operation"].freeze

    def include_status_url? params
      status_url = params[:status_url] || ""
      replacement_values = params[:replacement_values] || {}
      !(status_url.empty? || replacement_values.empty?)
    end

    def format_status_url params
      status_url = params[:status_url] || ""
      replacement_values = params[:replacement_values] || {}
      unless status_url.empty? || replacement_values.empty?
        uri = URI(status_url)
        params = URI.decode_www_form(uri.query || [])
        replacement_values.each_pair do |name, value|
          params << [name, value]
        end
        uri.query = URI.encode_www_form(params)
        status_url = uri.to_s
        Mozenda::ReplacementValues::ALL.each do |replacement_value|
          status_url = status_url.gsub(replacement_value, "%#{replacement_value}%")
        end
      end
      status_url
    end

  end
end
