class Puddy::AccountsController < Puddy::ApplicationController
  def index
    @accounts = Account.order(:name)
  end

  def show
    @account = AccountDecorator.new(Account.find(params[:id]))
  end
end
