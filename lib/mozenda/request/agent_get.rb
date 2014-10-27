module Mozenda::Request
  class AgentGet < Mozenda::Request::Base

    def initialize options
      super
      put_additional_param("AgentID", options[:agent_id])
    end

    private

    OPERATION = "Agent.Get"
    REQUIRED_PARAMS = ["AgentID", "Operation"].freeze

  end
end
