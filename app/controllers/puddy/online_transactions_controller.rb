class Puddy::OnlineTransactionsController < Puddy::ApplicationController
  def index
    @transaction_state = 'All'
    @transactions = OnlineTransaction.order(:created_at).
      paginate(page: params[:page], per_page: 25)
  end

  def show
    @transaction = OnlineTransaction.find params[:id]
    @credit_card = @transaction.payment.credit_card
    render '/transactions/show'
  end

  def successful
    @transaction_state = 'Successful'
    @transactions = OnlineTransaction.where(success: true).order(:created_at).
      paginate(page: params[:page], per_page: 25)
    render 'index'
  end

  def failed
    @transaction_state = 'Failed'
    @transactions = OnlineTransaction.where(success: false).order(:created_at).
      paginate(page: params[:page], per_page: 25)
    render 'index'
  end
end
