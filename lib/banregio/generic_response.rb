module Banregio
  class GenericResponse
    attr_reader :raw_response

    def initialize(raw_response)
      @raw_response = raw_response
    end

    def ==(other)
      self.class == other.class && raw_response == other.raw_response
    end
  end
end
