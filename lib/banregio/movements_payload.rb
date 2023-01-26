module Banregio
  class MovementsPayload < Payload
    attr_reader :bank_account, :initial_date, :final_date

    def initialize_options(initial_date:, final_date:)
      format = "%FT%T.000"
      @initial_date = initial_date.strftime(format)
      @final_date = final_date.strftime(format)
    end

    def to_h
      {
        "header": { "sequence": "token", "title": "Banregio" },
        "body": {
          "request": {
            "customer": customer,
            "service": "CH-IENTO-0301",
            "parameters": {
              "parameter": [
                { "key": "cliente", "value": customer},
                { "key": "cuentaNumero", "value": account},
                { "key": "movimientoNatural", "value": "" },
                { "key": "tipoConsulta", "value": "C5" },
                { "key": "fechaInicial", "value": initial_date },
                { "key": "fechaFinal", "value": final_date }
              ]
            }
          }
        }
      }
    end
  end
end
