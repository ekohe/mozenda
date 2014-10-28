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

  end
end
