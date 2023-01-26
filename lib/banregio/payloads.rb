module Banregio
  class Payloads
    attr_reader :account, :customer

    def initialize(account, customer)
      @account = account
      @customer = customer
    end

    def payload_for(key, options = {})
      keys = {
        movements: MovementsPayload,
        balance: BalancePayload,
        destination_accounts: DestinationAccountsPayload
      }

      payload = keys.fetch(key)
      payload.new(account, customer, options)
    end
  end
end
