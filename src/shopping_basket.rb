# frozen_string_literal: true
require 'pry'
# This class parses the input string and returns an array of hashes
class ShoppingBasket
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(basket_item)
    @items << basket_item
  end

  alias << add_item

  def total_tax
    return 0.0 if @items.empty?

    @items.map(&:tax).reduce(:+).round(2)
  end

  def total
    return 0.0 if @items.empty?

    @items.map(&:net_value).reduce(:+).round(2)
  end

  def to_s
    i = 0
    result = []
    items.each do |item|
      net_value_str = '%.2f' % item.net_value
      # result << "#{item.quantity} #{item.name}: #{net_value_str} (#{item.price} + #{item.tax})"
      result << "#{item.quantity} #{item.name}: #{net_value_str}"
      i += 1
    end
    total_tax_str = '%.2f' % total_tax
    result << "Sales Taxes: #{total_tax_str}"
    result << "Total: #{total}"
    result << ''
    result.join("\n")
  end
end
