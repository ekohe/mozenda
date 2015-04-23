module Mozenda::Response
  class CollectionAddField < Mozenda::Response::Base

    def item_id
      body_hash["FieldID"]
    end

    private

    NAME = "CollectionAddField"

  end
end
