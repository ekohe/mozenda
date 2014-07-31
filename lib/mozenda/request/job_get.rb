module Mozenda::Request
  class JobGet < Mozenda::Request::Base

    def initialize options
      super
      put_additional_param("JobID", options[:job_id])
    end

    private

    OPERATION = "Job.Get"
    REQUIRED_PARAMS = ["JobID", "Operation"].freeze

  end
end
