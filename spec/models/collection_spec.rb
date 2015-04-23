require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")

module Mozenda::Model
  describe Collection do

    it 'Collection.add, Collection.add_field, Collection.add_item, Collection.clear, Collection.delete' do
      collection_id = nil

      # Collection.add
      options = { Name: "From Mozenda API", Description: "Mozenda API Description" } 
      response = Mozenda::Model::Collection.new(nil).add(options)
      collection_id = response.item_id if response.success?

      # Collection.add_field
      options = { Field: "TestID", FieldDescription: "TestID Description" } 
      response = Mozenda::Model::Collection.new(collection_id).add_field(options)
      puts response.errors unless response.success?

      options   = { Field: "GetTest", FieldDescription: "GetTest Description" } 
      response  = Mozenda::Model::Collection.new(collection_id).add_field(options)
      puts response.errors unless response.success?

      # Collection.add_items_from_file
      path_to_xml_file = File.expand_path('../fixtures/test.xml', File.dirname(__FILE__))

      unless File.exists?( path_to_xml_file )
        # Collection.add_item
        options = { "TestID" => 100000, "GetTest" => true } 
        response = Mozenda::Model::Collection.new(collection_id).add_item(options)

        puts response.errors if response.success?
      else
        response = Mozenda::Model::Collection.new(collection_id).add_items_from_file(path_to_xml_file)
        puts response.errors unless response.success?
      end

      # # Collection.clear
      # response = Mozenda::Model::Collection.new(collection_id).clear
      # puts response.errors unless response.success?

      # # Collection.delete
      # response = Mozenda::Model::Collection.new(collection_id).delete
      # puts response.errors unless response.success?
      
    end
  end
end