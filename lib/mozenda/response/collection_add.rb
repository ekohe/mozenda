module Mozenda::Response
  class CollectionAdd < Mozenda::Response::Base

    def item_id
      body_hash["CollectionID"]
    end

    private

    NAME = "CollectionAddResponse"

  end
end
