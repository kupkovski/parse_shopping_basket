# frozen_string_literal: true

# utility class to check if line is unprocessably for the business logic
class UnprocessibleLineChecker
  def self.check(line)
    !line.match?(/^\d+ /)
  end
end