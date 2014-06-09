module Mozenda::Request
  class CollectionAddItemBulk < Mozenda::Request::CollectionAddItem

    def initialize options
      super
      @file_path = options[:file_path]
    end

    def send!
      validate!
      response = @connection.multipart(additional_params, @file_path)
      response_class.new(response)
    end

  end
end
