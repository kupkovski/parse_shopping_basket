# frozen_string_literal: true

require_relative './product'

# Decorator for products that are imported.
class ImportedProduct < Product
  def import_tax_rate
    Product::IMPORTED_TAX
  end

  def name
    "imported #{@name}"
  end
end