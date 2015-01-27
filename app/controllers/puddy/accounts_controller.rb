class Puddy::AccountsController < Puddy::ApplicationController
  helper_method :successful_transactions_total, :successful_transactions_count

  def index
  end

  def show
    @account = AccountDecorator.new(Account.find(params[:id]))
  end


  protected

  def successful_transactions_total
    Money.new(transactions_query["sum"]).format
  end

  def successful_transactions_count
    transactions_query["count"]
  end

  def transactions_query
    sql = %Q[SELECT SUM("amount_cents"), COUNT(*) FROM "transactions" WHERE "transactions"."success" = 't']
    Transaction.find_by_sql(sql).first
  end
end
