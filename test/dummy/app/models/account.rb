class Account < ActiveRecord::Base
  has_many :invoices
  has_many :transactions
end
