module Puddy
  class Dashboard
    def transactions_money_total
      Money.new(transactions_query["sum"]).format
    end

    def transactions_count
      transactions_query["count"]
    end

    def transactions_query
      sql = %Q[SELECT SUM("amount_cents"), COUNT(*) FROM "transactions" WHERE "transactions"."success" = 't']
      @transaction_query ||= Transaction.find_by_sql(sql).first
    end

    def transactions_this_week
      Transaction.where(success: true).
        order(:created_at).
        where(created_at: 1.week.ago..Date.today).
        count
    end


    def campers_count
      Camper.confirmed.count
    end

    def campers_this_week
      Camper.confirmed.
        order(:created_at).
        where(created_at: 1.week.ago..Date.today).
        count
    end

    def campers_week_over_week
      two_weeks_ago = Camper.confirmed.
        order(:created_at).
        where(created_at: 2.week.ago..1.weeks.ago).
        count

      week_over_week = campers_this_week - two_weeks_ago
      week_over_week >= 0 ? "+#{week_over_week}" : "-#{week_over_week}"
    end
  end
end
