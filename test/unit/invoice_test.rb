require 'test_helper'

module Puddy
  class InvoiceTest < ActiveSupport::TestCase
    # Test associations
    should belong_to :account

    # Test validations
    should validate_presence_of :month
    should validate_presence_of :year

    def test_setting_amount_on_save
      account = Account.create

      10.times { account.transactions.create success: true, amount: Money.new(1000) }
      invoice = Invoice.create account: account, month: Date.today.month,
        year: Date.today.year, payable: false

      # Amount should be 0.01 times $100.00
      assert_equal Money.new(100), invoice.amount
    end
  end
end
