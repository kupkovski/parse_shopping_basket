# frozen_string_literal: true

require_relative './basket_item'
require_relative './shopping_basket'
require_relative './tax_calculator'
require_relative './line_parser'
require_relative './unprocessable_line_checker'
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

      next if UnprocessibleLineChecker.check(line)

      LineParser.new(line).process(shopping_basket)
    end

    shopping_basket.to_s
  end
end
