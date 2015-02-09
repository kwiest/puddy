class Puddy::AccountsController < Puddy::ApplicationController
  def index
    @accounts = Account.order :name
  end

  def show
    account_model = Account.find params[:id]
    @account = AccountDecorator.new account_model
    @invoices = account_model.invoices.order :year, :month
  end
end
