module Puddy
  class Account < ActiveRecord::Base
    has_many :invoices
  end
end
