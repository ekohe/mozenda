module Mozenda::Request
  class CollectionDelete < Mozenda::Request::Base

    def initialize options
      super
      put_additional_param("CollectionID", options[:collection_id])
    end

    private

    OPERATION = "Collection.Delete"
    REQUIRED_PARAMS = ["CollectionID", "Operation"].freeze

  end
end
