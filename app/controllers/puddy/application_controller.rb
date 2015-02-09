module Puddy
  class ApplicationController < ActionController::Base
    layout 'puddy/dashboard'
    before_filter :http_basic_auth


    private

    def http_basic_auth
      authenticate_or_request_with_http_basic do |login, password|
        login == 'kwiest' && password == 'goducks888'
      end
    end
  end
end
