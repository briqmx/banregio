module Banregio
  class DestinationAccountsPayload < Payload
    def to_h
      {
        "header": { "title": "", "sequence": "" },
        "body": {
          "request": {
            "service": "HH-CTADE-0301",
            "customer": customer
          }
        }
      }
    end
  end
end
