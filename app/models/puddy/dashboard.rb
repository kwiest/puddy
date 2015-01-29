module Puddy
  class Dashboard
    def successful_transactions_total
      Money.new(transactions_query["sum"]).format
    end

    def successful_transactions_count
      transactions_query["count"]
    end

    def transactions_query
      sql = %Q[SELECT SUM("amount_cents"), COUNT(*) FROM "transactions" WHERE "transactions"."success" = 't']
      @transaction_query ||= Transaction.find_by_sql(sql).first
    end
  end
end
