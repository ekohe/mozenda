module Mozenda::Infrastructure
  class File

    def initialize file_path, root_name="ItemList"
      @path       = ::Pathname.new(file_path)
      @root_name  = root_name
    end

    def validate!
      item_list = to_h[@root_name]
      raise InvalidFileFormatException.new("Missing XML root tag: '#{@root_name}'") if item_list.nil?

      items = item_list["Item"]
      raise InvalidFileFormatException.new("Missing XML tag: 'Item'") if items.nil?

      items unless @root_name == "ItemList"
    end

    def to_h
      @hash ||= ::Nori.new.parse(content)
    end

    def content
      @content ||= @path.read
    end

  end
end
