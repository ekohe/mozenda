module Mozenda::Request
  class AgentGetJobs < Mozenda::Request::Base

    def initialize options
      super
      put_additional_param("AgentID", options[:agent_id])
    end

    private

    OPERATION = "Agent.GetJobs"
    REQUIRED_PARAMS = ["AgentID", "Operation"].freeze

  end
end
