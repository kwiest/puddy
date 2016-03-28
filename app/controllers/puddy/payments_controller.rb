class Puddy::PaymentsController < Puddy::ApplicationController
  def index
    @payment_state = 'All'
    @payments = Payment.where(payment_type: 'Online Credit Card').
      order('created_at DESC').
      paginate(page: params[:page], per_page: 25)
  end

  def show
    @payment = Payment.find params[:id]
    @credit_card = @payment.source
  end

  def successful
    @payment_state = 'Successful'
    @payments = Payment.paid.where(payment_type: 'Online Credit Card').
      order('created_at DESC').
      paginate(page: params[:page], per_page: 25)
    render 'index'
  end

  def failed
    @payment_state = 'Failed'
    @payments = Payment.declined.where(payment_type: 'Online Credit Card').
      order('created_at DESC').
      paginate(page: params[:page], per_page: 25)
    render 'index'
  end
end
