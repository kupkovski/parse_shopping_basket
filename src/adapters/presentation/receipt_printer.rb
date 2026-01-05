# frozen_string_literal: true

require_relative '../../core/ports/receipt_printer'

# Output adapter that prints the shopping basket receipt to STDOUT
class ReceiptPrinter
  include Core::Ports::ReceiptPrinter

  def print(shopping_basket)
    puts shopping_basket.to_s
  end
end