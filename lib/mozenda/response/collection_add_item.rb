module Mozenda::Response
  class CollectionAddItem < Mozenda::Response::Base

    def item_id
      body_hash["ItemID"]
    end

    private

    NAME = "CollectionAddItemResponse"

  end
end
