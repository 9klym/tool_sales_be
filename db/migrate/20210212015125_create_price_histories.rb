# frozen_string_literal: true

class CreatePriceHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :price_histories do |t|
      t.belongs_to :supplier_product
      t.decimal :price
      t.datetime :date
      t.timestamps
    end
  end
end
