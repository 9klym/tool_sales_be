# frozen_string_literal: true

class CreateInvoiceSupplierProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :invoice_supplier_products do |t|
      t.belongs_to :supplier_product
      t.belongs_to :invoice
      t.integer :count
      t.decimal :price
      t.timestamps
    end
  end
end
