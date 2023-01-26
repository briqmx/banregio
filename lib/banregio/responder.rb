module Banregio
  class Responder
    def response_for(key, raw_response)
      keys = {
        movements: MovementsResponse
      }

      response = keys.fetch(key) { GenericResponse }
      response.new(raw_response)
    end
  end
end
