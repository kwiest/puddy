class InvoicesController < ApplicationController
  respond_to :pdf, only: :show

  def show
    invoice = Invoice.find params[:id]

    if invoice.account.use_system_gateway?
      pdf = PayablePDF.new invoice
    else
      pdf = ReceivablePDF.new invoice
    end

    self.response.headers['Content-Type'] = 'application/pdf'
    self.response.headers['Content-Disposition'] = 'inline;'
    render text: pdf.render
  end
end
