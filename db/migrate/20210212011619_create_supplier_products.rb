# frozen_string_literal: true

class CreateSupplierProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :supplier_products do |t|
      t.belongs_to :supplier
      t.belongs_to :product
      t.decimal :price
      t.timestamps
    end
  end
end
