# frozen_string_literal: true

require_relative './product'

# Represents a product that is exempt from goods tax.
class ExemptProduct < Product
  def goods_tax_rate
    0.0
  end
end