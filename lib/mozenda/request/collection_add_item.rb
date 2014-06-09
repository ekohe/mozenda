module Mozenda::Request
  class CollectionAddItem < Mozenda::Request::Base

    def initialize options
      super
      put_additional_param("CollectionID", options[:collection_id])
      fields = options[:fields] || {}
      fields.each_pair do |name, value|
        put_additional_param("Field.#{name}", value)
      end
    end

    private

    OPERATION = "Collection.AddItem"
    REQUIRED_PARAMS = ["CollectionID", "Operation"].freeze

  end
end
