module Puddy
  class ReceivablePDF < InvoicePDF
    private

    def terms
      'Due upon receipt'
    end

    def column_widths
      [ 315, 75, 75, 75 ]
    end

    def table_header
      ['Description', 'Amount', 'CRS Fees', 'Total Due']
    end

    def line_items_data
      line_items.map do |li|
        [
          li.transaction.payment.description,
          li.transaction.amount.format,
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
        calculator.total_crs_fees.format,
        calculator.calculate_total.format
      ]
    end
  end
end
