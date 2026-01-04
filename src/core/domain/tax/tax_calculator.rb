# frozen_string_literal: true

require_relative 'tax_rounder'

# This class calculates taxes given a price and imported status
class TaxCalculator
  def initialize(product:)
    @product = product
  end

  def calculate
    total_tax = @product.price * (@product.goods_tax_rate + @product.import_tax_rate)
    TaxRounder.call(total_tax)
  end
end