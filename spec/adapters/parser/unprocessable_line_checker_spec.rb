# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../src/adapters/parser/unprocessable_line_checker'

describe UnprocessableLineChecker do
  describe '.check' do
    it 'returns false for lines starting with a number' do
      expect(described_class.check('1 book at 12.49')).to be false
    end

    it 'returns true for lines not starting with a number' do
      expect(described_class.check('invalid line')).to be true
      expect(described_class.check('')).to be true
      expect(described_class.check(' ')).to be true
    end
  end
end