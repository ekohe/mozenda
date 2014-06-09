module Mozenda::Response
  class AgentRun < Mozenda::Response::Base

    def agent_id
      body_hash["AgentID"]
    end

    def job_id
      body_hash["JobID"]
    end

    private

    NAME = "AgentRunResponse"

  end
end
