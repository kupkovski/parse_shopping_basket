# frozen_string_literal: true

require_relative '../../core/domain/product/product'
require_relative '../../core/domain/basket/shopping_basket'
require_relative '../presentation/receipt_printer'
require_relative 'line_parser'
require_relative '../parser/unprocessable_line_checker'
# This class parses the input string and orchestrates the receipt generation
class InputParser
  def parse(text)
    shopping_basket = ShoppingBasket.new

    text.each_line do |line|
      line.chomp!
      next if UnprocessableLineChecker.check(line)
      LineParser.new(line).process(shopping_basket)
    end
    ReceiptPrinter.new(shopping_basket).print
  end
end
