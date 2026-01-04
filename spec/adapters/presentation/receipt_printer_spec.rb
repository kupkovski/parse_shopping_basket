# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../src/adapters/presentation/receipt_printer'

describe ReceiptPrinter do
  let(:shopping_basket) { instance_double('ShoppingBasket', to_s: "Receipt Content") }
  subject { described_class.new(shopping_basket) }

  describe '#print' do
    it 'prints the shopping basket string representation to stdout' do
      expect { subject.print }.to output("Receipt Content\n").to_stdout
    end
  end
end