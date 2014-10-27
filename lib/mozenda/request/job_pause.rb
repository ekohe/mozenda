module Mozenda::Request
  class JobPause < Mozenda::Request::Base

    def initialize options
      super
      put_additional_param("JobID", options[:job_id])
    end

    private

    OPERATION = "Job.Pause"
    REQUIRED_PARAMS = ["JobID", "Operation"].freeze

  end
end
