class Mozenda::XmlGenerator

  def initialize data
    @data = data
  end

  def generate
    builder = ::Nokogiri::XML::Builder.new(encoding: 'utf-8') do |xml|
      xml.ItemList do
        @data.each do |hash|
          xml.Item do
            hash.each_pair do |tag_name, value|
              xml.send(:"#{tag_name}", value)
            end
          end
        end
      end
    end
    xml = builder.to_xml
    xml.encode(xml.encoding, :universal_newline => true)
  end

end
