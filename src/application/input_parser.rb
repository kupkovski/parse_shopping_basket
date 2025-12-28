# frozen_string_literal: true

require_relative '../domain/basket/basket_item'
require_relative '../domain/product/product'
require_relative '../domain/basket/shopping_basket'
require_relative '../infrastructure/presentation/receipt_printer'
require_relative '../infrastructure/parser/line_parser'
require_relative '../infrastructure/parser/unprocessable_line_checker'

# This class parses the input string and orchestrates the receipt generation
class InputParser
  def parse(text)
    shopping_basket = ShoppingBasket.new

    text.each_line do |line|
      line.chomp!
      next if UnprocessibleLineChecker.check(line)
      LineParser.new(line).process(shopping_basket)
    end
    ReceiptPrinter.new(shopping_basket).print
  end
end