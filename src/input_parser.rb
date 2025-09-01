# frozen_string_literal: true

require_relative './basket_item'
require_relative './shopping_basket'
require_relative './tax_calculator'
require 'pry'

# This class parses the input string and returns an array of Products
class InputParser
  PARSING_REGEXP = {
    price: /(?<= at )\d+\.\d+/.freeze,
    imported: /imported/.freeze,
    exempt: /book|chocolate|pills/.freeze,
    name: /(?<=\d )(.*)(?= at )/.freeze,
    quantity: /^\d+/.freeze
  }.freeze

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
    price = line.match(PARSING_REGEXP[:price])[0]
    imported = line.match?(PARSING_REGEXP[:imported])
    exempt = line.match?(PARSING_REGEXP[:exempt])

    quantity = line.match(PARSING_REGEXP[:quantity])[0].to_i
    name = line.match(PARSING_REGEXP[:name])[0].strip

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
