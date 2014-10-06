module Mozenda::Response
  class JobGet < Mozenda::Response::Base

    def job_id
      job_data["JobID"]
    end

    def state
      job_data["State"]
    end

    def error?
      state.downcase == "error"
    end

    private

    NAME = "JobGetResponse"

    def job_data
      body_hash["Job"]
    end

  end
end
