class Transaction < ActiveRecord::Base
  belongs_to :account

  attr_accessible :amount, :success

  include Monetizable
  monetize 'amount'

  def self.for_month(month, year)
    start_date = Date.new(year, month, 1)
    end_date   = start_date.end_of_month
    where(success: true).where(created_at: start_date..end_date)
  end
end
