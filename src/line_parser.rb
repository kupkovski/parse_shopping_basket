# frozen_string_literal: true

require_relative './tax_calculator'
require_relative './basket_item'

# parses a single line and generates objects for each item
class LineParser
  PARSING_REGEXP = {
    price: /(?<= at )\d+\.\d+/.freeze,
    imported: /imported/.freeze,
    exempt: /book|chocolate|pills/.freeze,
    name: /(?<=\d )(.*)(?= at )/.freeze,
    quantity: /^\d+/.freeze
  }.freeze

  def initialize(line)
    @line = line
  end

  def price
    line.match(PARSING_REGEXP[:price])[0]
  end

  def imported
    line.match?(PARSING_REGEXP[:imported])
  end

  def exempt
    line.match?(PARSING_REGEXP[:exempt])
  end

  def quantity
    line.match(PARSING_REGEXP[:quantity])[0].to_i
  end

  def name
    line.match(PARSING_REGEXP[:name])[0].strip
  end

  def process(shopping_basket)
    quantity.times do
      shopping_basket << BasketItem.new(name: name, price: price, tax: tax)
    end
  end

  private

  def tax
    TaxCalculator.new(
      price: price,
      imported: imported,
      exempt: exempt
    ).calculate
  end

  attr_reader :line
end
