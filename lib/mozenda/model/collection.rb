module Mozenda::Model
  class Collection < Mozenda::Model::Base

    def initialize collection_id
      @id = collection_id
    end

    def add fields
      request = Mozenda::Request::CollectionAdd.new({
        :fields => fields
      })
      request.send!
    end

    def add_field fields
      request = Mozenda::Request::CollectionAddField.new({
        :collection_id => @id,
        :fields => fields
      })
      request.send!
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

    def clear
      request = Mozenda::Request::CollectionClear.new(:collection_id => @id)
      request.send!
    end

    def delete
      request = Mozenda::Request::CollectionDelete.new(:collection_id => @id)
      request.send!
    end

    def publish job_params = {}
      request = Mozenda::Request::CollectionPublish.new({
        :collection_id => @id,
        :job_params => job_params
      })
      request.send!
    end

  end
end
