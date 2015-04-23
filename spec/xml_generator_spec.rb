require "spec_helper.rb"

module Mozenda
  describe XmlGenerator do
    it 'Generate XML file' do
      data = [
        { 'TestID' => 100000, "GetTest" => true },
        { 'TestID' => 100001, "GetTest" => true },
        { 'TestID' => 100002, "GetTest" => true },
        { 'TestID' => 100003, "GetTest" => true },
        { 'TestID' => 100004, "GetTest" => true }
      ]
      xml_generator = Mozenda::XmlGenerator.new(data)
      xml = xml_generator.generate

      path_to_xml_file = File.expand_path('fixtures/test.xml', File.dirname(__FILE__))

      File.delete(path_to_xml_file) if File.exists?( path_to_xml_file )
      f = File.new(path_to_xml_file, 'w') 
      f.write(xml) 
      f.close 
    end
  end
end