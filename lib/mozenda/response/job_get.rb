module Mozenda::Response
  class JobGet < Mozenda::Response::Base

    def job_id
      body_hash["JobID"]
    end

    def state
      body_hash["State"]
    end

    def error?
      state.downcase == "error"
    end

    private

    NAME = "JobGetResponse"

  end
end
