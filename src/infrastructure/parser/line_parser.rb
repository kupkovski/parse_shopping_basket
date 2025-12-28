# frozen_string_literal: true

require_relative '../../domain/basket/basket_item'
require_relative '../../domain/product/product'
require_relative '../../domain/product/exempt_product'
require_relative '../../domain/product/imported_product'
require_relative '../../domain/product/imported_exempt_product'
require_relative '../../domain/product/product_factory'

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
    quantity.times { shopping_basket << BasketItem.new(product: product, name: name) }
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
    product_class = ProductFactory.for(imported: imported, exempt: exempt)
    @product ||= product_class.new(name: name, price: price)
  end

  attr_reader :line
end