module Puddy
  class Invoice < ActiveRecord::Base
    belongs_to :account, class_name: '::Account'

    validates :month, presence: true
    validates :year,  presence: true

    include Monetizable
    monetize 'amount'

    attr_protected :state
    state_machine initial: :pending do
      state :paid

      event :payment_confirmed do
        transition all => :paid
      end
    end

    before_save :calculate_amount

    def transactions
      @transactions ||= account.transactions.for_month month, year
    end

    def date
      Date.new(year, month).strftime "%b, %Y"
    end

    def calculate_amount
      self.amount = InvoiceCalculator.new(self).calculate_total
    end
  end
end
