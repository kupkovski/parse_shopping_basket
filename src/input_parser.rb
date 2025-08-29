# frozen_string_literal: true

require_relative './basket_item'
require_relative './shopping_basket'
require_relative './tax_calculator'
require 'pry'

# This class parses the input string and returns an array of Products
class InputParser
  PRICE_REGEXP = /(?<= at )\d+\.\d+/
  IMPORTED_REGEXP = /imported/
  EXEMPT_REGEXP = /book|chocolate|pills/
  NAME_REGEXP = /(?<=\d )(.*)(?= at )/
  QUANTITY_REGEXP = /^\d+/

  attr_reader :shopping_basket

  def initialize
    @shopping_basket = ShoppingBasket.new
  end

  def parse(text)
    text.each_line do |line|
      line.chomp!

      next if unprocessible_line?(line)

      process_line(line)
    end

    shopping_basket.to_s
  end

  private

  def process_line(line)
    price = line.match(PRICE_REGEXP)[0]
    imported = line.match?(IMPORTED_REGEXP)
    exempt = line.match?(EXEMPT_REGEXP)

    quantity = line.match(QUANTITY_REGEXP)[0].to_i
    name = line.match(NAME_REGEXP)[0].strip

    add_basket_item(price, imported, exempt, quantity, name)
  end

  def add_basket_item(price, imported, exempt, quantity, name)
    tax = TaxCalculator.new(price: price, imported: imported, exempt: exempt).calculate
    quantity.times { shopping_basket << BasketItem.new(name: name, price: price, tax: tax) }
  end

  def unprocessible_line?(line)
    !line.match?(/^\d+ /)
  end
end
