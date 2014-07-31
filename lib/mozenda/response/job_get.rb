module Mozenda::Response
  class JobGet < Mozenda::Response::Base

    def job_id
      body_hash["JobID"]
    end

    private

    NAME = "JobGetResponse"

  end
end
