class Puddy::AccountsController < Puddy::ApplicationController
  helper_method :successful_transactions_total, :successful_transactions_count

  def show
    @account = AccountDecorator.new(Account.find(params[:id]))
  end
end
