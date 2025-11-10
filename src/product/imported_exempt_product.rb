# frozen_string_literal: true

require_relative './exempt_product'

# Represents a product that is both imported and exempt from goods tax.
class ImportedExemptProduct < ExemptProduct
  def import_tax_rate
    Product::IMPORTED_TAX
  end

  def name
    "imported #{@name}"
  end
end