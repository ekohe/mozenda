module Mozenda::Request
  class CollectionClear < Mozenda::Request::Base

    def initialize options
      super
      put_additional_param("CollectionID", options[:collection_id])
    end

    private

    OPERATION = "Collection.Clear"
    REQUIRED_PARAMS = ["CollectionID", "Operation"].freeze

  end
end
