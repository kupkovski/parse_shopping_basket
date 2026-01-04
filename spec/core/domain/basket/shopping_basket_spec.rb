# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../../src/core/domain/basket/shopping_basket'

describe ShoppingBasket do
  subject { described_class.new }

  let(:item1) { instance_double('BasketItem', name: 'book', tax: 0.0, net_value: 12.49) }
  let(:item2) { instance_double('BasketItem', name: 'music CD', tax: 1.50, net_value: 16.49) }

  describe '#add_item' do
    it 'adds items to the basket' do
      subject.add_item(item1)
      expect(subject.items).to include(item1)
    end
  end

  describe '#total_tax' do
    it 'sums the tax of all items' do
      subject.add_item(item1)
      subject.add_item(item2)
      expect(subject.total_tax).to eq(1.50)
    end
  end

  describe '#total' do
    it 'sums the net value of all items' do
      subject.add_item(item1)
      subject.add_item(item2)
      expect(subject.total).to eq(28.98)
    end
  end

  describe '#aggregate_items' do
    it 'returns an array of formatted item strings' do
      subject.add_item(item1)
      subject.add_item(item2)
      expect(subject.aggregate_items).to eq(['1 book: 12.49', '1 music CD: 16.49'])
    end

    it 'groups identical items' do
      subject.add_item(item1)
      subject.add_item(item1)
      expect(subject.aggregate_items).to eq(['2 book: 24.98'])
    end
  end

  describe '#aggregate_totals' do
    it 'returns formatted tax and total lines' do
      subject.add_item(item1)
      subject.add_item(item2)
      expect(subject.aggregate_totals).to eq(['Sales Taxes: 1.50', 'Total: 28.98', ''])
    end
  end

  describe '#to_s' do
    it 'returns the formatted receipt' do
      subject.add_item(item1)
      subject.add_item(item2)
      expected_output = "1 book: 12.49\n1 music CD: 16.49\nSales Taxes: 1.50\nTotal: 28.98\n"
      expect(subject.to_s).to eq(expected_output)
    end
  end
end