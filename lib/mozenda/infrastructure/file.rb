module Mozenda::Infrastructure
  class File

    def initialize file_path
      @path = ::Pathname.new(file_path)
    end

    def validate!
      item_list = to_h["ItemList"]
      raise InvalidFileFormatException.new("Missing XML root tag: 'ItemList'") if item_list.nil?
      items = item_list["Item"]
      raise InvalidFileFormatException.new("Missing XML tag: 'Item'") if items.nil?
    end

    def to_h
      @hash ||= ::Nori.new.parse(content)
    end

    def content
      @content ||= @path.read
    end

  end
end
