class Puddy::ApplicationController < ActionController::Base
  layout 'puddy/dashboard'
  before_filter :http_basic_auth

  helper_method :accounts


  protected

  def accounts
    Account.order :name
  end


  private

  def http_basic_auth
    authenticate_or_request_with_http_basic do |login, password|
      login == 'kwiest' && password == 'goducks888'
    end
  end

end
