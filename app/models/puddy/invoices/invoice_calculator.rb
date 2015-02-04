module Puddy
  InvoiceCalculator = Struct.new(:invoice) do
    GATEWAY_PERCENTAGE_FEE = 0.029 # 2.9%
    CRS_PERCENTAGE_FEE     = 0.01  # 1%

    def calculate_total
      if invoice.payable?
        (transactions_total - total_fees) * -1
      else
        total_crs_fees
      end
    end

    def transactions_total
      total_cents = invoice.transactions.sum &:amount_cents
      Money.new total_cents
    end

    def total_crs_fees
      transactions_total * CRS_PERCENTAGE_FEE
    end

    def total_fees
      total_crs_fees + total_gateway_fees
    end

    def total_gateway_fees
      return Money.new(0) if invoice.transactions.empty?
      return Money.new(0) unless invoice.payable?
      (transactions_total * GATEWAY_PERCENTAGE_FEE) + Money.new(30)
    end
  end
end
