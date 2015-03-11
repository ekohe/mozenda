module Mozenda::Response
  class AgentGetJobs < Mozenda::Response::Base

    def job_list
      result = body_hash["JobList"]["Job"] rescue []
      Array.wrap(result)
    end

    private

    NAME = "AgentGetJobsResponse"

  end
end
