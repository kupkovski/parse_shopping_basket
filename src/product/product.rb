# frozen_string_literal: true

require_relative '../tax/tax_calculator'

# This class represents a product with its properties.
class Product
  GOODS_TAX = 0.1
  IMPORTED_TAX = 0.05

  attr_reader :name, :price

  def initialize(name:, price:)
    @name = name
    @price = price.to_f
  end

  def tax
    @tax ||= TaxCalculator.new(product: self).calculate
  end

  def net_price
    (price + tax).round(2)
  end

  def goods_tax_rate
    GOODS_TAX
  end

  def import_tax_rate
    0.0
  end
end