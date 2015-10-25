module Puddy
  class InvoiceLineItem
    GATEWAY_PERCENTAGE_FEE = 0.029 # 2.9%
    CRS_PERCENTAGE_FEE     = 0.01  # 1%

    attr_reader :payment

    def initialize(payment)
      @payment = payment
    end

    def crs_fee
      payment.amount * CRS_PERCENTAGE_FEE
    end

    def gateway_fee
      (payment.amount * GATEWAY_PERCENTAGE_FEE) + Money.new(30)
    end

    def total_due
      if payment.account.use_system_gateway?
        crs_fee + gateway_fee
      else
        crs_fee
      end
    end
  end
end
