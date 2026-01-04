# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../src/adapters/parser/input_parser'

describe InputParser do
  subject { described_class.new }

  let(:shopping_basket) { instance_double('ShoppingBasket') }
  let(:receipt_printer) { instance_double('ReceiptPrinter') }
  let(:line_parser) { instance_double('LineParser') }

  before do
    allow(ShoppingBasket).to receive(:new).and_return(shopping_basket)
    allow(ReceiptPrinter).to receive(:new).with(shopping_basket).and_return(receipt_printer)
    allow(receipt_printer).to receive(:print)
    allow(UnprocessableLineChecker).to receive(:check).and_return(false)
    allow(LineParser).to receive(:new).and_return(line_parser)
    allow(line_parser).to receive(:process)
  end

  describe '#parse' do
    let(:input) { "1 book at 12.49\n1 music CD at 14.99" }

    it 'processes each line and prints receipt' do
      subject.parse(input)

      expect(ShoppingBasket).to have_received(:new)
      expect(LineParser).to have_received(:new).with('1 book at 12.49')
      expect(LineParser).to have_received(:new).with('1 music CD at 14.99')
      expect(line_parser).to have_received(:process).with(shopping_basket).twice
      expect(ReceiptPrinter).to have_received(:new).with(shopping_basket)
      expect(receipt_printer).to have_received(:print)
    end

    it 'skips unprocessable lines' do
      allow(UnprocessableLineChecker).to receive(:check).with('invalid').and_return(true)
      subject.parse("1 book at 12.49\ninvalid")

      expect(LineParser).to have_received(:new).with('1 book at 12.49')
      expect(LineParser).not_to have_received(:new).with('invalid')
    end
  end
end