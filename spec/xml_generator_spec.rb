require "spec_helper.rb"

module Mozenda
  describe XmlGenerator do
    it 'Generate' do
      data = [
        { 'Name' => "Test1", "Count" => 12 },
        { 'Name' => "Test2", "Count" => 99 },
        { 'Name' => "Test3", "Count" => 23 }
      ]
      xml_generator = Mozenda::XmlGenerator.new(data)
      xml = xml_generator.generate
    end
  end
end