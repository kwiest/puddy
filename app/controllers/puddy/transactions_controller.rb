module Puddy
  class TransactionsController < ApplicationController
    def index
      @transaction_state = 'All'
      @transactions = Transaction.order(:created_at).
        paginate(page: params[:page], per_page: 25)
    end

    def successful
      @transaction_state = 'Successful'
      @transactions = Transaction.where(success: true).order(:created_at).
        paginate(page: params[:page], per_page: 25)
      render 'index'
    end

    def failed
      @transaction_state = 'Failed'
      @transactions = Transaction.where(success: false).order(:created_at).
        paginate(page: params[:page], per_page: 25)
      render 'index'
    end
  end
end
