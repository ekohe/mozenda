module Mozenda::Response
  class AgentGetJobs < Mozenda::Response::Base

    def job_list
      body_hash["JobList"]["Job"]
    end

    private

    NAME = "AgentGetJobsResponse"

  end
end
