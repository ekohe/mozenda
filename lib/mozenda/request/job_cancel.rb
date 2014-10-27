module Mozenda::Request
  class JobCancel < Mozenda::Request::Base

    def initialize options
      super
      put_additional_param("JobID", options[:job_id])
    end

    private

    OPERATION = "Job.Cancel"
    REQUIRED_PARAMS = ["JobID", "Operation"].freeze

  end
end
