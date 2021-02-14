# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :vendor_code
      t.string :image
      t.timestamps
    end
  end
end
