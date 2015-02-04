module Puddy
  class InvoiceLineItem
    GATEWAY_PERCENTAGE_FEE = 0.029 # 2.9%
    CRS_PERCENTAGE_FEE     = 0.01  # 1%

    attr_reader :transaction

    def initialize(transaction)
      @transaction = transaction
    end

    def crs_fee
      transaction.amount * CRS_PERCENTAGE_FEE
    end

    def gateway_fee
      (transaction.amount * GATEWAY_PERCENTAGE_FEE) + Money.new(30)
    end

    def total_due
      if @transaction.account.use_system_gateway?
        crs_fee + gateway_fee
      else
        crs_fee
      end
    end
  end
end
