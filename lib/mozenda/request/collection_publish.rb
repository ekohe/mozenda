module Mozenda::Request
  class CollectionPublish < Mozenda::Request::Base

    def initialize options
      super
      put_additional_param("CollectionID", options[:collection_id])
      job_params = options[:job_params] || {}
      put_additional_param("Job.StatusUrl", format_status_url(job_params)) unless job_params.empty?
    end

    private

    OPERATION = "Collection.Publish"
    REQUIRED_PARAMS = ["CollectionID", "Operation"].freeze

  end
end
