module Mozenda::Request
  class CollectionAdd < Mozenda::Request::Base

    def initialize options
      super
      fields = options[:fields] || {}
      fields.each_pair do |name, value|
        put_additional_param("#{name.to_s}", value)
      end
    end

    private

    OPERATION = "Collection.Add"
    REQUIRED_PARAMS = ["Operation"].freeze

  end
end
