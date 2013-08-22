class Puddy::AccountsController < Puddy::ApplicationController
  def index
  end

  def show
    @account = AccountDecorator.new(Account.find(params[:id]))
  end
end
