class Account < ActiveRecord::Base
  has_many :invoices
  has_many :transactions

  attr_accessible :invoices, :transactions, :use_system_gateway
end
