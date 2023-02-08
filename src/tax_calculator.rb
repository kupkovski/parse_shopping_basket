# frozen_string_literal: true

require 'pry'
# This class calculates taxes given a price and imported status
class TaxCalculator
  attr_reader :price, :imported, :exempt

  ROUND_FACTOR = 1 / 0.05

  def initialize(price:, imported:, exempt:)
    @price = price.to_f
    @imported = imported
    @exempt = exempt
  end

  def calculate
    import_tax = 0
    goods_tax = 0

    import_tax = 0.05 if imported
    goods_tax += 0.1 unless exempt
    total_tax = (price * (import_tax + goods_tax))
    round_tax(total_tax)
  end

  def round_tax(total_tax)
    (total_tax * ROUND_FACTOR).ceil / ROUND_FACTOR
  end
end
