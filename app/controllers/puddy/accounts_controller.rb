module Puddy
  class AccountsController < ApplicationController
    def index
    end

    def show
      @account = Account.find params[:id]
    end
  end
end
