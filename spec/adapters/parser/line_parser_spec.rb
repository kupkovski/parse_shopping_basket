# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../src/adapters/parser/line_parser'

describe LineParser do
  let(:shopping_basket) { instance_double('ShoppingBasket') }
  let(:basket_item_class) { class_double('BasketItem').as_stubbed_const }
  let(:product_factory) { class_double('ProductFactory').as_stubbed_const }
  let(:product) { instance_double('Product') }
  let(:product_class) { double('ProductClass', new: product) }

  before do
    allow(shopping_basket).to receive(:<<)
    allow(product_factory).to receive(:for).and_return(product_class)
    allow(basket_item_class).to receive(:new)
  end

  describe '#process' do
    context 'with a valid line' do
      subject { described_class.new('1 book at 12.49') }

      it 'creates a basket item and adds it to the basket' do
        subject.process(shopping_basket)

        expect(product_factory).to have_received(:for).with(imported: false, exempt: true)
        expect(product_class).to have_received(:new).with(name: 'book', price: 12.49)
        expect(basket_item_class).to have_received(:new).with(product: product, name: 'book')
        expect(shopping_basket).to have_received(:<<)
      end
    end
  end
end