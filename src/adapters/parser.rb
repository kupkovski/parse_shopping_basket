# frozen_string_literal: true

# utility class to check if line is unprocessable for the business logic
class UnprocessableLineChecker
  def self.check(line)
    !line.match?(/^\d+ /)
  end
end