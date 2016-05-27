class Puddy::AccountsController < Puddy::ApplicationController
  def index
    @accounts = Account.order :name
  end

  def show
    account_model = Account.find params[:id]
    @account = AccountDecorator.new account_model
    @invoices = account_model.invoices.order :year, :month
  end

  def payments
    @account = Account.find params[:id]

    @start_date = params.fetch :start_date, Date.today - 30.days
    @end_date   = params.fetch :end_date, Date.today

    @payments = @account.payments.where(payment_type: 'Online Credit Card',
                                        created_at: @start_date..@end_date)
  end
end
