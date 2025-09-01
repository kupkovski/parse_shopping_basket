# frozen_string_literal: true

require_relative 'tax_rounder'

# This class calculates taxes given a price and imported status
class TaxCalculator
  ROUND_FACTOR = 1 / 0.05
  IMPORTED_TAX = 0.05
  GOODS_TAX    = 0.1

  def initialize(price:, imported:, exempt:)
    @price = price.to_f
    @imported = imported
    @exempt = exempt
  end

  def calculate
    total_tax = @price * (import_value + goods_value)
    TaxRounder.call(total_tax)
  end

  private

  def import_value
    imported? ? IMPORTED_TAX : 0
  end

  def goods_value
    exempt? ? 0 : GOODS_TAX
  end

  def imported?
    @imported
  end

  def exempt?
    @exempt
  end
end
