module Mozenda::Request
  class CollectionAddItem < Mozenda::Request::Base

    def initialize options
      super
      @additional_params = {
        "CollectionID" => options[:@collection_id]
      }
      fields = options[:fields] || {}
      fields.each_pair do |name, value|
        @additional_params["Field.#{name}"] = value
      end
    end

    private

    OPERATION = "Collection.AddItem"
    REQUIRED_PARAMS = ["CollectionID", "Operation"].freeze
    DEFAULT_PARAMS = {
      "Operation" => OPERATION
    }.freeze

    def additional_params
      @additional_params ||= DEFAULT_PARAMS.merge(@additional_params)
    end

  end
end
