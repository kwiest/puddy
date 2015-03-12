class Puddy::InvoicesController < Puddy::ApplicationController
  respond_to :pdf, only: :show

  before_filter :assign_account

  def show
    invoice = Puddy::Invoice.find params[:id]

    if @account.use_system_gateway?
      pdf = Puddy::PayablePDF.new invoice
    else
      pdf = Puddy::ReceivablePDF.new invoice
    end

    self.response.headers['Content-Type'] = 'application/pdf'
    self.response.headers['Content-Disposition'] = 'inline;'
    render text: pdf.render
  end

  def assign_account
    @account = ::Account.find params[:account_id]
  end

end
