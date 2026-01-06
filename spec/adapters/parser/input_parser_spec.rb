# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../src/adapters/parser/input_parser'

describe InputParser do
  subject { described_class.new(receipt_printer) }

  let(:shopping_basket) { instance_double('ShoppingBasket') }
  let(:receipt_printer) { instance_double('ReceiptPrinter') }
  let(:line_parser) { instance_double('LineParser') }

  before do
    allow(ShoppingBasket).to receive(:new).and_return(shopping_basket)
    allow(receipt_printer).to receive(:print)
    allow(LineParser).to receive(:new).and_return(line_parser)
    allow(line_parser).to receive(:process)
    allow(line_parser).to receive(:unprocessable?).and_return false
  end

  describe '#parse' do
    let(:input) { "1 book at 12.49\n1 music CD at 14.99" }

    it 'processes each line and prints receipt' do
      subject.parse(input)

      expect(ShoppingBasket).to have_received(:new)
      expect(LineParser).to have_received(:new).with('1 book at 12.49')
      expect(LineParser).to have_received(:new).with('1 music CD at 14.99')
      expect(line_parser).to have_received(:process).with(shopping_basket).twice
      expect(receipt_printer).to have_received(:print).with(shopping_basket)
    end

    it 'skips unprocessable lines' do
      allow(line_parser).to receive(:unprocessable?).and_return true
      subject.parse("1 book at 12.49\ninvalid")

      expect(LineParser).to have_received(:new).with('1 book at 12.49')
    end
  end
end
