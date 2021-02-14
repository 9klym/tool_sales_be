# frozen_string_literal: true

class Invoice < ApplicationRecord
  has_many :supplier_products, through: :invoice_supplier_products
  has_many :invoice_supplier_products, dependent: :destroy

  validates :date, presence: true
end
