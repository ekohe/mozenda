module Mozenda::Response
  class AgentGetJobs < Mozenda::Response::Base

    def job_list
      Array.wrap(body_hash["JobList"]["Job"] rescue [])
    end

    private

    NAME = "AgentGetJobsResponse"

  end
end
