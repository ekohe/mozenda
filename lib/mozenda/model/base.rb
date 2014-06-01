module Mozenda::Model
  class Base

    def initialize
      @connection = Mozenda::Infrastructure::Connection.instance
    end

  end
end
