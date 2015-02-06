class MoveInvoices < ActiveRecord::Migration
  def change
    rename_table :invoices, :puddy_invoices
  end
end
