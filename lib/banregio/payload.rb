require "json"

module Banregio
  class Payload
    attr_reader :account, :customer

    def initialize(account, customer, options = {})
      @account = account
      @customer = customer
      initialize_options(**options)
    end

    def initialize_options(**options)
    end

    def to_h
      {}
    end

    def to_json
      to_h.to_json
    end
  end
end
