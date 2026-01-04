# frozen_string_literal: true

# Output adapter that prints the shopping basket receipt to STDOUT
class ReceiptPrinter
  def initialize(shopping_basket)
    @shopping_basket = shopping_basket
  end

  def print
    puts @shopping_basket.to_s
  end
end