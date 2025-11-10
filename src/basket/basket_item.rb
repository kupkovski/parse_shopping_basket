# frozen_string_literal: true

require_relative '../product/product'
require 'forwardable'

# This class represents an item in the shopping basket, which is a specific product.
class BasketItem
  extend Forwardable

  attr_reader :product

  def initialize(product:)
    @product = product
  end

  def_delegators :@product, :name, :tax, :net_price
  alias net_value net_price
end