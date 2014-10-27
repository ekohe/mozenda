module Mozenda::Response
  class CollectionPublish < Mozenda::Response::Base

    def job_id
      body_hash["JobID"]
    end

    private

    NAME = "CollectionPublishResponse"

  end
end
