class Puddy::AccountPaymentsController < Puddy::ApplicationController
  def index
    @account    = Account.find params[:account_id]
    @start_date = params.fetch :start_date, Date.today - 30.days
    @end_date   = params.fetch :end_date, Date.today

    @payments = @account.payments.where(payment_type: 'Online Credit Card',
                                        created_at: @start_date..@end_date)
  end
end
