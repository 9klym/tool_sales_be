# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :supplier_products
  has_many :suppliers, through: :supplier_products

  validates :name, presence: true
  validates :vendor_code, presence: true
end
