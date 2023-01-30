# frozen_string_literal: true

require 'pry'
# This class calculates taxes given a price and imported status
class TaxCalculator
  attr_reader :price, :imported, :exempt

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
    (price * (import_tax + goods_tax)).round(2)
  end
end
