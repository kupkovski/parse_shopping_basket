# frozen_string_literal: true

require 'forwardable'
require_relative './product'
require_relative '../tax/tax_calculator'

# Decorator for products that are imported.
class ImportedProduct
  extend Forwardable

  def_delegators :@product, :price, :goods_tax_rate

  def initialize(product)
    @product = product
  end

  def import_tax_rate
    Product::IMPORTED_TAX
  end

  def tax
    @tax ||= TaxCalculator.new(product: self).calculate
  end

  def net_price
    (price + tax).round(2)
  end

  def name
    "imported #{@product.name}"
  end
end