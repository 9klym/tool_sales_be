# frozen_string_literal: true

class PriceHistory < ApplicationRecord
  has_many :supplier_products

  validates :price, presence: true, numericality: { greater_than: 0.1 }
  validates :date, presence: true
end
