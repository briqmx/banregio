module Banregio
  class MovementsResponse
    MOVEMENTS_POSITION = ["body", "response", "description"]

    attr_reader :raw_response

    def initialize(raw_response)
      @raw_response = raw_response
    end

    def ==(other)
      self.class == other.class && raw_response == other.raw_response
    end

    def all
      raw_response.dig(*MOVEMENTS_POSITION).map do |descripcion|
        MovementResponse.new(descripcion)
      end
    end
  end
end
