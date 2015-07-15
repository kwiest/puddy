module Puddy
  module TransactionsHelper
    def transaction_class(transaction)
      transaction.success? ? '' : 'failed'
    end
  end
end
