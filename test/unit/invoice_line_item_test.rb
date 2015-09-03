require 'test_helper'

module Puddy
  class InvoiceLineItemTest < Minitest::Test
    # Should have a transaction
    # should calculate crs fee
    # should calculate gateway fee

    def setup
      @transaction = Transaction.new amount: 10
      @line_item   = InvoiceLineItem.new @transaction
      @account     = Account.create transactions: [@transaction]
    end

    def test_has_a_transaction
      assert_equal @transaction, @line_item.transaction
    end

    def test_calcualting_crs_fee
      # CRS Fees are 1.0%
      assert_instance_of Money, @line_item.crs_fee
      assert_equal Money.new(10), @line_item.crs_fee
    end

    def test_gateway_fee
      # Gateway fee is 2.9% = $0.30
      assert_instance_of Money, @line_item.gateway_fee
      assert_equal Money.new(59, 'USD'), @line_item.gateway_fee
    end

    def test_total_due_when_account_uses_system_gateway
      @account.update_attributes use_system_gateway: true
      assert @account.use_system_gateway?
      assert_equal Money.new(69), @line_item.total_due
    end

    def test_total_due_when_account_doesnt_use_system_gateway
      @account.update_attributes use_system_gateway: false
      assert_equal Money.new(10), @line_item.total_due
    end
  end
end
