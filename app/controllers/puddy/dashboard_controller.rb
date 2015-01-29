class Puddy::DashboardController < Puddy::ApplicationController
  def show
    @dashboard = Puddy::Dashboard.new
  end
end
