module Banregio
  class BalancePayload < Payload
    def to_h
      {
        "header": { "title": "", "sequence": "" },
        "body": {
          "request": {
            "service": "CH-SALDO-0301",
            "customer": customer,
            "parameters": {
              "parameter": [
                { "key": "numeroCliente", "value": customer },
                { "key": "numeroCuenta", "value": account },
              ]
            }
          }
        }
      }
    end
  end
end
