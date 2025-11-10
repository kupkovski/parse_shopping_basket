# frozen_string_literal: true

require_relative '../basket/basket_item'
require_relative '../product/product'
require_relative '../product/exempt_product'
require_relative '../product/imported_product'

# parses a single line and generates objects for each item
class LineParser
  PARSING_REGEXP = {
    price: /(?<= at )\d+\.\d+/.freeze,
    imported: /imported/.freeze,
    exempt: /book|chocolate|pills/.freeze,
    name: /(?<=\d )(?:imported )?(.*)(?= at )/.freeze,
    quantity: /^\d+/.freeze
  }.freeze

  def initialize(line)
    @line = line
  end

  def process(shopping_basket)
    quantity.times { shopping_basket << BasketItem.new(product: product) }
  end

  private

  def quantity
    line.match(PARSING_REGEXP[:quantity])[0].to_i
  end

  def price
    line.match(PARSING_REGEXP[:price])[0].to_f
  end

  def name
    line.match(PARSING_REGEXP[:name])[1].strip
  end

  def imported
    line.match?(PARSING_REGEXP[:imported])
  end

  def exempt
    line.match?(PARSING_REGEXP[:exempt])
  end

  def product
    product_class = exempt ? ExemptProduct : Product
    base_product = product_class.new(name: name, price: price)
    @product ||= imported ? ImportedProduct.new(base_product) : base_product
  end

  attr_reader :line
end