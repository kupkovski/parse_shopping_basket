# frozen_string_literal: true

# This class parses the input string and returns an array of hashes
class BasketItem
  attr_reader :name, :price, :tax

  def initialize(name:, price:, tax:)
    @name = name
    @price = price.to_f
    @tax = tax.to_f
  end

  def net_value
    (price + tax).round(2)
  end
end
