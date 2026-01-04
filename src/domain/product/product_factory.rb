# frozen_string_literal: true

require_relative './product'
require_relative './exempt_product'
require_relative './imported_product'
require_relative './imported_exempt_product'

# Factory for creating the correct product instance based on its properties.
class ProductFactory
  Key = Struct.new(:imported, :exempt, keyword_init: true)

  CLASS_MAP = {
    Key.new(imported: true, exempt: true)   => ImportedExemptProduct,
    Key.new(imported: true, exempt: false)  => ImportedProduct,
    Key.new(imported: false, exempt: true)  => ExemptProduct,
    Key.new(imported: false, exempt: false) => Product
  }.freeze

  def self.for(imported:, exempt:)
    key = Key.new(imported: imported, exempt: exempt)
    CLASS_MAP[key]
  end
end