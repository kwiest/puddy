module Puddy
  class InvoicePDF
    attr_reader :invoice, :pdf

    def initialize(invoice)
      @invoice = invoice
      @pdf     = Prawn::Document.new
    end

    def render
      render_header
      render_transaction_detail
      pdf.render
    end


    private

    def line_items
      @line_items ||= @invoice.payments.map { |p| InvoiceLineItem.new(p) }
    end

    def render_header
      render_crs_info_box
      render_account_info_box

      pdf.move_down 20

      pdf.text "Total due: #{invoice.amount.format}"
      pdf.text "Terms: #{terms}"
      if invoice.paid?
        pdf.image [Rails.root + 'app/assets/images/paid_stamp.png'].join
      end

      pdf.move_down 20
    end

    def render_crs_info_box
      pdf.bounding_box [340, 720], width: 200 do
        pdf.image [Rails.root + 'app/assets/images/crs_logo_186x40.png'].join
        pdf.text %q{ Camp Registration Systems, LLC
          PO Box 771
          Junction City, OR 97448
        }
      end
    end

    def render_account_info_box
      pdf.bounding_box [0, 680], width: 400 do
        pdf.text %Q{ Account: #{invoice.account.name}
          Transactions during: #{invoice.date}
          Invoice #: #{invoice.id}
        }, inline_text: true
      end
    end

    def render_transaction_detail
      pdf.text 'Transaction detail:', style: :italic
      render_transactions_table
    end

    def render_transactions_table
      table_options = {
        header: true,
        column_widths: column_widths,
        row_colors: %w(FFFFFF EFEFEF)
      }

      data = line_items_data.prepend(table_header).push(table_footer)

      pdf.table data, table_options do
        row(0).font_style = :bold
        row(0).background_color = '999999'

        rows(1..-1).valign = :center
        rows(1..-1).size = 10

        row(-1).font_style = :bold_italic

        columns(1..3).align = :center
      end
    end
  end
end
