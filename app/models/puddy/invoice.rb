module Puddy
  class Invoice < ActiveRecord::Base
    belongs_to :account, class_name: '::Account'

    validates :month, presence: true
    validates :year,  presence: true

    include Monetizable
    monetize 'amount'

    state_machine initial: :pending do
      state :paid

      event :payment_confirmed do
        transition all => :paid
      end
    end

    before_save :calculate_amount

    def transactions
      @transactions ||= account.payments.where(
        payment_type: 'Online Credit Card',
        state: 'paid',
        created_at: start_date..end_date
      )
    end

    def start_date
      Date.new year, month, 1
    end

    def end_date
      start_date.end_of_month
    end

    def date
      Date.new(year, month).strftime "%b, %Y"
    end

    def calculate_amount
      self.amount = InvoiceCalculator.new(self).calculate_total
    end
  end
end
