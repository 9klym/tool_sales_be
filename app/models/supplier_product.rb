# frozen_string_literal: true

class SupplierProduct < ApplicationRecord
  belongs_to :product
  belongs_to :supplier
  has_many :price_histories
  has_many :invoices, through: :invoice_supplier_products
  has_many :invoice_supplier_products

  validates :price, presence: true, numericality: { greater_than: 0.1 }
end
