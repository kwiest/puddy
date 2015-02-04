require 'test_helper'

module Puddy
  class InvoiceGeneratorTest < ActiveSupport::TestCase
    def setup
      @account = Account.create
      @month   = Date.today.month
      @year    = Date.today.year
      @invoice = InvoiceGenerator.new(@account, @month, @year).generate
    end

    def test_creates_a_new_invoice_for_an_account
      assert_equal @account, @invoice.account
      assert_equal @month, @invoice.month
      assert_equal @year, @invoice.year
    end

    def test_setting_payable_boolean
      generator = InvoiceGenerator.new @account, @month, @year

      generator.stubs(:payable?).returns true
      invoice = generator.generate
      assert invoice.payable?

      generator.stubs(:payable?).returns false
      invoice = generator.generate
      refute invoice.payable?
    end
  end
end
