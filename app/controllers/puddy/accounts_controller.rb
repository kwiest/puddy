module Puddy
  class AccountsController < ApplicationController
    def index
    end

    def show
      @account = AccountDecorator.new(Account.find(params[:id]))
    end
  end
end
