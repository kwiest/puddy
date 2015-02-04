module Puddy
  class PayablePDF < InvoicePDF

    private

    def terms
      'Payment enclosed'
    end

    def column_widths
      [ 215, 75, 100, 75, 75 ]
    end

    def table_header
      [
        'Description',
        'Amount',
        'Gateway Fees (2.9% + $0.30)',
        'CRS Fees',
        'Total Due'
      ]
    end

    def line_items_data
      line_items.map do |li|
        [
          li.transaction.payment.description,
          li.transaction.amount.format,
          li.gateway_fee.format,
          li.crs_fee.format,
          li.total_due.format
        ]
      end
    end

    def table_footer
      calculator = InvoiceCalculator.new(invoice)
      [
        'Totals',
        calculator.transactions_total.format,
        calculator.total_gateway_fees.format,
        calculator.total_crs_fees.format,
        calculator.calculate_total.format
      ]
    end
  end
end
