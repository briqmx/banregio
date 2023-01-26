require "json"

module Banregio
  class ApiClient
    def self.from_config(config)
      ApiClientFactory.new.build(**config)
    end

    def initialize(requester, payloads, responder)
      @requester = requester
      @payloads = payloads
      @responder = responder
    end

    def movements(options)
      execute(:movements, options)
    end

    def balance
      execute(:balance)
    end

    def destination_accounts
      execute(:destination_accounts)
    end

    private

    attr_reader :requester, :payloads, :responder

    def execute(request, options = {})
      payload = payloads.payload_for(request, options)
      response = requester.execute(payload)
      responder.response_for(request, JSON.parse(response.body))
    end
  end
end
