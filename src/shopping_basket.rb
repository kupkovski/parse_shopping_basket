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
    (aggregate_items + aggregate_totals).join("\n")
  end

  def aggregate_items
    items.group_by(&:name).map do |name, items|
      net_value_str = format('%<offset>.2f', offset: items.sum(&:net_value))
      "#{items.size} #{name}: #{net_value_str}"
    end
  end

  def aggregate_totals
    total_tax_str = format('%<offset>.2f', offset: total_tax)
    ["Sales Taxes: #{total_tax_str}", "Total: #{total}", '']
  end
end
