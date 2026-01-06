# frozen_string_literal: true

require_relative '../../core/domain/product/product'
require_relative '../../core/domain/basket/shopping_basket'
require_relative 'line_parser'

# This class parses the input string and orchestrates the receipt generation
class InputParser
  def initialize(printer)
    @printer = printer
  end

  def parse(text)
    shopping_basket = ShoppingBasket.new

    text.each_line do |raw_line|
      raw_line.chomp!
      line = LineParser.new(raw_line)
      next if line.unprocessable?
      line.process(shopping_basket)
    end
    @printer.print(shopping_basket)
  end
end
