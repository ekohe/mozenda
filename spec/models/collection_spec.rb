require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")

module Mozenda::Model
  describe Collection do

    it 'Collection.add, Collection.add_field, Collection.add_item, Collection.clear, Collection.delete' do
      collection_id = nil

      # Collection.add
      options = { Name: "From Mozenda API", Description: "Mozenda API Description" } 
      response = Mozenda::Model::Collection.new(nil).add(options)

      if response.success?
        collection_id = response.item_id
        puts response.to_h
      else
        puts response.errors
      end

      # Collection.add_field
      options = { Field: "Test1", FieldDescription: "Test1 Description" } 
      response = Mozenda::Model::Collection.new(collection_id).add_field(options)

      if response.success?
        puts response.to_h
      else
        puts response.errors
      end

      # Collection.add_item
      options = { "Test1" => 'text1' } 
      response = Mozenda::Model::Collection.new(collection_id).add_item(options)

      if response.success?
        puts response.to_h
      else
        puts response.errors
      end

      # Collection.clear
      response = Mozenda::Model::Collection.new(collection_id).clear

      if response.success?
        puts response.to_h
      else
        puts response.errors
      end

      # Collection.delete
      response = Mozenda::Model::Collection.new(collection_id).delete

      if response.success?
        puts response.to_h
      else
        puts response.errors
      end
      
    end
  end
end