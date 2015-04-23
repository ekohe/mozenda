# encoding: utf-8

module Mozenda::Request
  class CollectionAddField < Mozenda::Request::Base

    def initialize options
      super
      put_additional_param("CollectionID", options[:collection_id])
      fields = options[:fields] || {}
      fields.each_pair do |name, value|
        put_additional_param("#{name.to_s}", value)
      end
    end

    private

    OPERATION = "Collection.AddField"
    REQUIRED_PARAMS = ["CollectionID", "Operation"].freeze

  end
end

