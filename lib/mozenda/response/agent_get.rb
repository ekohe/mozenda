module Mozenda::Response
  class AgentGet < Mozenda::Response::Base

    def agent_id
      body_hash["AgentID"]
    end

    def collection_id
      body_hash["CollectionID"]
    end

    private

    NAME = "AgentGetResponse"

  end
end
