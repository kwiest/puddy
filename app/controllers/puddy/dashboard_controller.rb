module Puddy
  class DashboardController < ApplicationController
    def show
      @dashboard = Puddy::Dashboard.new
    end
  end
end
