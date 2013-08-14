module Puddy
  class ApplicationController < ActionController::Base
    layout 'puddy/dashboard'

    helper_method :accounts

    protected

    def accounts
      Account.order :name
    end
  end
end
