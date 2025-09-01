# frozen_string_literal: true

# Utility class to perform the rounding of a value according to the specifications
class TaxRounder
  ROUND_FACTOR = 1 / 0.05

  def self.call(value)
    (value.truncate(2) * ROUND_FACTOR).ceil / ROUND_FACTOR
  end
end
