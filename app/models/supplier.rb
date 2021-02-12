# frozen_string_literal: true

class Supplier < ApplicationRecord
  has_many :supplier_products
  has_many :products, through: :supplier_products

  validates :name, presence: true
  validates :phone, presence: true
end
