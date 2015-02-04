require 'test_helper'

module Puddy
  class InvoiceCalculatorTest < ActiveSupport::TestCase
    context 'when invoice is payable' do
      def invoice
        stub(payable?: false, transactions: [])
      end

      def test_total_is_zero_if_no_transactions
        calc = InvoiceCalculator.new invoice
        assert_equal Money.new(0), calc.calculate_total
      end
    end
  end
end
