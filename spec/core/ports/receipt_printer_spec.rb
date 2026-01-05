# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../src/core/ports/receipt_printer'

describe Core::Ports::ReceiptPrinter do
  let(:dummy_class) { Class.new { include Core::Ports::ReceiptPrinter } }
  subject { dummy_class.new }

  describe '#print' do
    it 'raises NotImplementedError' do
      expect { subject.print(double) }.to raise_error(NotImplementedError, /has not implemented method 'print'/)
    end
  end
end