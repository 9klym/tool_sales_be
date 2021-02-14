# frozen_string_literal: true

class InvoiceSupplierProduct < ApplicationRecord
  belongs_to :invoice
  belongs_to :supplier_product

  validates :count, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0.1 }
end
