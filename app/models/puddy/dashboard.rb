module Puddy
  class Dashboard
    def transactions_money_total
      Money.new(transactions_query["sum"]).format
    end

    def transactions_count
      transactions_query["count"]
    end

    def transactions_query
      sql = %Q[SELECT SUM("amount_cents"), COUNT(*) FROM "online_transactions" WHERE "transactions"."success" = 't']
      @transaction_query ||= OnlineTransaction.find_by_sql(sql).first
    end

    def transactions_this_week
      OnlineTransaction.where(success: true).
        order(:created_at).
        where(created_at: 1.week.ago..Date.today).
        count
    end


    def campers_count
      Camper.confirmed.count
    end

    def campers_this_week
      @campers_this_week ||= Camper.confirmed.
        order(:created_at).
        where(created_at: 1.week.ago.to_date..Date.today).
        count
    end

    def campers_two_weeks_ago
      @campers_two_weeks_ago ||= Camper.confirmed.
        order(:created_at).
        where(created_at: 2.weeks.ago.to_date..1.week.ago.to_date).
        count
    end

    def campers_week_over_week
      v1 = campers_this_week.to_f
      v2 = campers_two_weeks_ago.to_f
      week_over_week = ((v1 - v2)/(v1 == 0.0 ? 1 : v1)*100.0).round 2

      case
      when week_over_week == 0.0 then "0.0%"
      when week_over_week > 0.0
        %Q{<span class="change-up">
          <b class="icon icon-chevron-up"></b>
          #{week_over_week}%
        </span>
        }.html_safe
      when week_over_week < 0.0 then
        %Q{<span class="change-down">
          <b class="icon icon-chevron-down"></b>
          #{week_over_week.abs}%
        </span>
        }.html_safe
      end
    end
  end
end
