# frozen_string_literal: true

require_relative './basket_item'
require_relative './shopping_basket'
require_relative './tax_calculator'
require 'pry'

# This class parses the input string and returns an array of Products
class InputParser
  attr_reader :shopping_basket

  def initialize
    @shopping_basket = ShoppingBasket.new
  end

  def parse(text)
    text.each_line do |line|
      line.chomp!
      next if line.empty?

      imported = false
      exempt = false

      if line.match?(/^Input \d+:/)
        input_number = line.match(/\d+/)[0]
        next
      end

      imported = true if line.match?(/imported/)
      exempt = true if line.match?(/book|chocolate|pills/)

      next unless line.match?(/^\d+ /)

      quantity = line.match(/^\d+/)[0]
      name = line.match(/(?<=\d )(.*)(?= at )/)[0].strip
      price = line.match(/(?<= at )\d+\.\d+/)[0]
      net_price = price.to_f * quantity.to_i

      tax = TaxCalculator.new(price: net_price, imported: imported, exempt: exempt).calculate

      basket_item = BasketItem.new(quantity: quantity, name: name, price: net_price, tax: tax)
      shopping_basket << (basket_item)
    end
    shopping_basket.to_s
  end
end
