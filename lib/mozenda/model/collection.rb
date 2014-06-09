module Mozenda::Model
  class Collection < Mozenda::Model::Base

    def initialize collection_id
      @id = collection_id
    end

    def add_item fields
      request = Mozenda::Request::CollectionAddItem.new({
        :collection_id => @id,
        :fields => fields
      })
      request.send!
    end

    def add_items_from_file file_path
      request = Mozenda::Request::CollectionAddItemBulk.new({
        :collection_id => @id,
        :file_path => file_path
      })
      request.send!
    end

  end
end
