module Puddy
  class InvoiceGenerator
    attr_reader :account, :month, :year
    
    def initialize(account, month, year)
      @account = account
      @month = month
      @year = year
    end

    def generate
      Invoice.create(
        account: account,
        month: month,
        year: year,
        payable: payable?
      )
    end

    def payable?
      account.use_system_gateway?
    end
  end
end
