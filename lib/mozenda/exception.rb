module Mozenda
  class Exception < ::Exception
  end

  class ConfigurationException < Exception
  end

  class MissingMethodException < Exception
  end

  class InvalidRequestException < Exception
  end

  class ResponseTypeException < Exception
  end

  class InvalidFileFormatException < Exception
  end
end
